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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    
    NSString *str = [NSString stringWithFormat:@"icone_calendario_%02ld.png",(long)day];
    [self firstButtonMethod:nil withImage:[UIImage imageNamed:str]];
    [self secondButtonMethod:nil withImage:[UIImage imageNamed:@"icon_compartilhar.png"]];
    [self thirdButtonMethod:nil withImage:[UIImage imageNamed:@"icon_pontuacao.png"]];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    MenuShouldOpen *temp = [MenuShouldOpen alloc];
    [temp setOpen:YES];
}


@end
