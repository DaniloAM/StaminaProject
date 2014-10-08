//
//  HomeScreenVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 06/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "HomeScreenVC.h"

@interface HomeScreenVC ()

@end

@implementation HomeScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    height = height*167.67/1137.11;
    //AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    
    CGFloat navBarHeight = height;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    
    //UILabel *labelText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, navBarHeight /4)];
    
    CGRect frame = CGRectMake(0.0f, 0.0f, width, navBarHeight);
    [self.navigationController.navigationBar setFrame:frame];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, navBarHeight /4, width, navBarHeight /4)];
    [label setTextAlignment:NSTextAlignmentCenter]; //to center text in the UILabel
    
    [label setBackgroundColor:[UIColor greenColor]];
    [label  setText:@"stamina.com"];
    //[label addSubview:labelText];

    [self.navigationController.navigationBar addSubview:label];

}


@end
