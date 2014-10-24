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

    NSArray *array =  [super criaBarButtonComBotoes:3];
    
    UIButton *btn = [array objectAtIndex:0];
    
    [btn addTarget:self action:@selector(function1) forControlEvents:UIControlEventTouchUpInside];
    btn = [array objectAtIndex:1];
    [btn addTarget:self action:@selector(acessaRanking) forControlEvents:UIControlEventTouchUpInside];
    btn = [array objectAtIndex:2];
    [btn addTarget:self action:@selector(criaTreino) forControlEvents:UIControlEventTouchUpInside];
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
    NSLog(@"btn2");
}
-(void)function3{
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated withGesture:1];
}
-(void)criaTreino{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC;
    myVC= (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CriaTreino"];
    
    [self.navigationController pushViewController:myVC animated:YES];
}
-(void)acessaRanking{
    
}
@end
