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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES withGesture:1];
    NSArray *array =  [super criaBarButton];
    
    UIButton *btn = [array objectAtIndex:0];
    
    [btn addTarget:self action:@selector(function1) forControlEvents:UIControlEventTouchUpInside];
    btn = [array objectAtIndex:1];
    [btn addTarget:self action:@selector(function2) forControlEvents:UIControlEventTouchUpInside];
    btn = [array objectAtIndex:2];
    [btn addTarget:self action:@selector(function3) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor    blackColor]];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.height*0.75, btn.frame.size.height*0.75)];
    [image  setImage:[UIImage imageNamed:@"icone_ok.png"]];
    [btn addSubview:image];
    [image setCenter:CGPointMake(btn.frame.size.width/2, btn.frame.size.height/2)];
}
-(void)function1{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)function2{
    
}
-(void)function3{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC;
    myVC= (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CriaTreino"];
    
    [self.navigationController pushViewController:myVC animated:YES];
}
@end
