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
    [super viewWillAppear:YES];

    
    [self firstButtonMethod:@selector(function1) withImage:[UIImage imageNamed:@"icon_home.png"]];
    [self secondButtonMethod:@selector(function2) withImage:[UIImage imageNamed:@"icon_adicionar.png"]];
    [self thirdButtonMethod:@selector(function3) withImage:[UIImage imageNamed:@"icon_editar.png"]];
    }
-(void)function1{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)function2{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC;
    myVC= (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CriaTreino"];
    
    [self.navigationController pushViewController:myVC animated:YES];
}
-(void)function3{

}
@end
