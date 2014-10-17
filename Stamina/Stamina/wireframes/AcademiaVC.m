//
//  AcademiaVC.m
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 09/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "AcademiaVC.h"

@interface AcademiaVC ()

@end

@implementation AcademiaVC

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *array =  [super criaBarButtonComBotoes:10];
    UIButton *btn = [array objectAtIndex:0];
    [btn addTarget:self action:@selector(function1) forControlEvents:UIControlEventTouchUpInside];
}
-(void)function1{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)function2{
    NSLog(@"btn2");
}
-(void)function3{
    NSLog(@"Criar um treino");

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated withGesture:1];
    [super viewWillDisappear:animated];
}

@end
