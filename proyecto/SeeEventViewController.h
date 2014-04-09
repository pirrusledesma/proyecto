//
//  SeeEventViewController.h
//  proyecto
//
//  Created by Ileana Padilla on 4/7/14.
//  Copyright (c) 2014 paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface SeeEventViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(strong,nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *contactDB;
@property(weak,nonatomic) IBOutlet UITableView *table;


@end
