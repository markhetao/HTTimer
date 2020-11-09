//
//  HTViewController.m
//  HTTimer
//
//  Created by markhetao@sina.com on 11/08/2020.
//  Copyright (c) 2020 markhetao@sina.com. All rights reserved.
//

#import "HTViewController.h"
#import "HTPushViewController.h"

@interface HTViewController ()

@end

@implementation HTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)push:(id)sender {
    [self.navigationController pushViewController:[HTPushViewController new] animated:true];
}

@end
