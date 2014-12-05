//
//  MenuRunningVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 28/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "MenuRunningVC.h"

@interface MenuRunningVC ()

@end

@implementation MenuRunningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *date = [NSDate date];
     NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay fromDate:date];
    
    [[self calendarIcon] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icone_calendario_%02d.png", (int) comp.day]]];

    
    UISwipeGestureRecognizer *backGest = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backToHomeScreen)];
    
    backGest.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:backGest];
    
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //[self removeGestureFromMenuVC];
    
}

-(void)backToHomeScreen {
    
    [self.navigationController popToRootViewControllerAnimated:true];
    
}




@end
