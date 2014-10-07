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
    
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    
    [mainVC configureLeftMenuButton:_leftMenuBtn];
    [_leftMenuBtn addTarget:mainVC action:@selector(openLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
}


@end
