//
//  NGAHomeViewController.m
//  iNGA
//
//  Created by WildCat on 1/13/14.
//  Copyright (c) 2014 WildCat. All rights reserved.
//

#import "NGAHomeViewController.h"

@interface NGAHomeViewController ()

@end

@implementation NGAHomeViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}



@end
