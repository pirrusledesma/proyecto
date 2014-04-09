//
//  DetailViewController.h
//  proyecto
//
//  Created by Ileana Padilla on 4/4/14.
//  Copyright (c) 2014 paul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSString *nombre;
@property (strong, nonatomic) IBOutlet UILabel *labeld;
- (IBAction)btnCompartir:(id)sender;


@end
