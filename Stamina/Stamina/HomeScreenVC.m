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
 
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    MenuShouldOpen *temp = [MenuShouldOpen alloc];
    [temp setOpen:YES];
}


@end
