//
//  PageContentViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "TipsVC.h"

@interface TipsVC ()

@end

@implementation TipsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    MenuShouldOpen *menu = [MenuShouldOpen alloc];
    [menu setOpen:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    MenuShouldOpen *menu = [MenuShouldOpen alloc];
    [self.navigationItem setHidesBackButton:YES];

    [menu setOpen:NO];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    MenuShouldOpen *menu = [MenuShouldOpen alloc];
    [menu setOpen:NO];

}
-(void)viewWillDisappear:(BOOL)animated{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
