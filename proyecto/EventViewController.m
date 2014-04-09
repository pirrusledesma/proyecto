//
//  EventViewController.m
//  proyecto
//
//  Created by Ileana Padilla on 4/7/14.
//  Copyright (c) 2014 paul. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    self.databasePath = [[NSString alloc]
                         initWithString: [docsDir stringByAppendingPathComponent:
                                          @"contacts.db"]];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: self.databasePath ] == NO)
    {
        const char *dbpath = [self.databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        {
            NSLog(@"Error no hay tabla");
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS EVENTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, DATE TEXT, PLACE TEXT, DESCRIPTOR TEXT)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                self.status.text = @"Failed to create table";
            }
            sqlite3_close(self.contactDB);
        }
        else
        {
            self.status.text = @"Failed to open/create database";
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)findEvent:(id)sender {
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT date,place,descriptor  FROM EVENTS WHERE name=\"%@\"",
                              _name.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *dateField = [[NSString alloc]
                                          initWithUTF8String:
                                          (const char *) sqlite3_column_text(
                                                                             statement, 0)];
                _date.text = dateField;
                
                NSString *placeField = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 1)];
                _place.text = placeField;
                
                NSString *descriptorField = [[NSString alloc]
                                             initWithUTF8String:
                                             (const char *)sqlite3_column_text(
                                                                               statement, 2)];
                _descriptor.text = descriptorField;
                
                _status.text = @"Match found";
            } else {
                _status.text = @"Match not found";
                _date.text = @"";
                _place.text = @"";
                _descriptor.text = @"";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }

    
}


- (IBAction)saveEvent:(id)sender {
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO EVENTS (name, date, place, descriptor) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",
                               _name.text, _date.text, _place.text, _descriptor.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            self.status.text = @"Contact added";
            self.name.text = @"";
            self.date.text = @"";
            self.place.text = @"";
            self.descriptor.text = @"";
            NSLog(@"Saved");
        }
        else
        {
            _status.text = @"Failed to add contact";
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }

}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view]endEditing:YES];
}


- (IBAction)btnShare:(id)sender {
    NSString *name;
    NSString *date;
    NSString *place;
    NSString *descriptor;
    NSString *temporal;
    
    name = self.name.text;
    date = self.date.text;
    place = self.place.text;
    descriptor = self.descriptor.text;
    
    NSString                  *initialTextString;
    NSArray                   *activityItems;
    //UIImage                   *imagesScreen;
    UIActivityViewController  *activityViewController;
    
    temporal=[NSString stringWithFormat:@"Nombre:%@\nFecha:%@\nLugar:%@\nDescripcion:%@",name,date,place,descriptor];
    //imagesScreen = [UIImage imageNamed:@"uag.jpeg"];
    initialTextString = temporal;
    
    //INIT ACTIVITY VIEW CONTROLLES
    
    activityItems = @[temporal];
    
    activityViewController = [[UIActivityViewController alloc]
                              initWithActivityItems:activityItems applicationActivities:nil];
    
    activityViewController.excludedActivityTypes=[NSArray arrayWithObjects:UIActivityTypeAssignToContact,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAirDrop,nil];
    
    [self presentViewController:activityViewController animated: YES completion:nil];

    
}
@end
