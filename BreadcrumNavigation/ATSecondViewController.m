//
//  ATSecondViewController.m
//  BreadcrumNavigation
//
//  Created by Akbar Nurlybayev on 2014-04-16.
//  Copyright (c) 2014 Akbar Nurlybayev. All rights reserved.
//

#import "ATSecondViewController.h"

@interface ATSecondViewController ()

@end

@implementation ATSecondViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)breadcrumTitle
{
    return @"Second";
}

- (NSString *)breadcrumSubtitle
{
    return @"View Controller";
}

@end
