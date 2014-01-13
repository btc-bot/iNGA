//
//  NGASettingViewController.m
//  iNGA
//
//  Created by WildCat on 1/13/14.
//  Copyright (c) 2014 WildCat. All rights reserved.
//

#import "NGASettingViewController.h"
#import "RESideMenu.h"

@interface NGASettingViewController ()

@end

@implementation NGASettingViewController

- (IBAction)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}

- (IBAction)pushController:(id)sender
{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = @"Pushed Controller";
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
