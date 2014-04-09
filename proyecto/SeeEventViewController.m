//
//  SeeEventViewController.m
//  proyecto
//
//  Created by Ileana Padilla on 4/7/14.
//  Copyright (c) 2014 paul. All rights reserved.
//

#import "SeeEventViewController.h"
#import "Cell_EventCell.h"
#import "EventViewController.h"
#import "AppDelegate.h"

@interface SeeEventViewController (){
    NSMutableArray *array1;
    NSMutableArray *array2;
    NSMutableArray *array3;
    NSMutableArray *array4;
    NSString *querySQL;
    NSString *nombre;
    NSString *fecha;
    NSString *lugar;
    NSString *descripcion;
}

@end

@implementation SeeEventViewController

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
    array1=[[NSMutableArray alloc]init];
    array2=[[NSMutableArray alloc]init];
    array3=[[NSMutableArray alloc]init];
    array4=[[NSMutableArray alloc]init];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
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
                //self.status.text = @"Failed to create table";
            }
            sqlite3_close(self.contactDB);
        }
        else
        {
            //self.status.text = @"Failed to open/create database";
        }
    }
    [self findPerson];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [array1 count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Cell_EventCell *cell;
    static NSString *CellIdentifier = @"Cell_EventCell";
    
    cell = (Cell_EventCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[Cell_EventCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    
    cell.labelNombre.text =[array1 objectAtIndex:indexPath.row];
    cell.labelFecha.text =[array2 objectAtIndex:indexPath.row];
    cell.labelLugar.text =[array3 objectAtIndex:indexPath.row];
    cell.labelDescrip.text =[array4 objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)findPerson
{
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        querySQL = [NSString stringWithFormat:
                    @"SELECT NAME, DATE, PLACE, DESCRIPTOR FROM EVENTS"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
                
            {
                
                nombre = [[NSString alloc]
                                initWithUTF8String:
                                (const char *) sqlite3_column_text(
                                                                   statement, 0)];
                fecha = [[NSString alloc]
                            initWithUTF8String:
                            (const char *) sqlite3_column_text(
                                                               statement, 1)];
                lugar = [[NSString alloc]
                        initWithUTF8String:
                        (const char *) sqlite3_column_text(
                                                           statement, 2)];
                descripcion = [[NSString alloc]
                        initWithUTF8String:
                        (const char *) sqlite3_column_text(
                                                           statement, 3)];
                
                [array1 addObject:nombre];
                [array2 addObject:fecha];
                [array3 addObject:lugar];
                [array4 addObject:descripcion];
                
                //guardarlo en arreglo
                NSLog(@"%@",nombre);
                NSLog(@"%@",array1);
                
                //_status.text = @"Match found";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
}

@end
