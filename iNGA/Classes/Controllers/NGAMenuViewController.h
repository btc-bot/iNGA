//
//  NGAMenuViewController.h
//  iNGA
//
//  Created by WildCat on 1/13/14.
//  Copyright (c) 2014 WildCat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface NGAMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RESideMenuDelegate>

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end
