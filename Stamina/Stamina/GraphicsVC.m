//
//  GraphicsVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 28/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "GraphicsVC.h"

@implementation GraphicsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestUpdater *up = [[TestUpdater alloc] init];
    
    [up setNumberInView:7];
    
    _graphic = [[GraphicScroller alloc] init];
    
    [[self graphic] setGraphicFont:[UIFont fontWithName:@"Lato" size:14.0]];
    [[self graphic] startNewGraphicScrollViewWithUpdater:up expanded:true];
    
    [[[self graphic] graphicScrollView] setCenter:self.view.center];
    
    [self.view addSubview:[[self graphic] graphicScrollView]];
    [self.view addSubview:[[self graphic] monthLabel]];
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //[self panLeft].enabled = false;
    //[self.navigationController.view removeGestureRecognizer:[self panLeft]];
}


@end
