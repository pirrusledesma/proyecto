//
//  EventViewController.h
//  proyecto
//
//  Created by Ileana Padilla on 4/7/14.
//  Copyright (c) 2014 paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface EventViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *date;
@property (strong, nonatomic) IBOutlet UITextField *place;
@property (strong, nonatomic) IBOutlet UITextView *descriptor;
@property (strong, nonatomic) IBOutlet UILabel *status;

- (IBAction)saveEvent:(id)sender;
- (IBAction)findEvent:(id)sender;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
- (IBAction)btnShare:(id)sender;

@end
