//
//  NGARootViewController.m
//  iNGA
//
//  Created by WildCat on 1/13/14.
//  Copyright (c) 2014 WildCat. All rights reserved.
//

#import "NGARootViewController.h"
#import "NGAMenuViewController.h"

@interface NGARootViewController ()

@end

@implementation NGARootViewController


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

- (void)awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    self.backgroundImage = [UIImage imageNamed:@"Stars"];
    self.delegate = (NGAMenuViewController *)self.menuViewController;
}

@end
