//
//  HideBBVC.m
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 09/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "HideBBVC.h"

@interface HideBBVC ()

@end

@implementation HideBBVC

-(void)viewWillAppear:(BOOL)animated{
    [self viewWillAppear:animated withGesture:1];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated withGesture: (BOOL)gesture{
    [super viewWillAppear:animated];
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp cleanButtons];
    [self.navigationItem setHidesBackButton:YES];
}
//-(void)unblock{
//    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
//    [temp setStop:YES];
//    [temp panLeft].enabled = YES;
//    [self.navigationController.view setUserInteractionEnabled:YES];
//    [self.view setUserInteractionEnabled:YES];
//    [self.navigationController.view addGestureRecognizer:[temp panLeft]];
//}
//-(void)block{
//    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
//    [temp setStop:NO];
//    [temp panLeft].enabled = NO;
//    [self.navigationController.view removeGestureRecognizer:[temp panLeft]];
//    [self.navigationController.view setUserInteractionEnabled:NO];
//    [self.view setUserInteractionEnabled:NO];
//}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
}


-(CGSize )tabBarSize{
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    return [temp tabBar].frame.size;
}


-(void)showBarWithAnimation: (BOOL)animation{
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp showBarWithAnimation:animation];
}
-(void)hideBarWithAnimation: (BOOL)animation{
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp hideBarWithAnimation:animation];
}


-(CGSize)navigationSize{
    return [self.navigationController navigationBar].frame.size;
}

-(void)firstButtonMethod: (void *)metodo fromClass:(UIViewController *)view withImage: (UIImage *)image{
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp firstButtonMethod:metodo fromClass:view withImage:image];
}
-(void)secondButtonMethod: (void *)metodo fromClass:(UIViewController *)view withImage: (UIImage *)image{
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp secondButtonMethod:metodo fromClass:view withImage:image];

}
-(void)thirdButtonMethod: (void *)metodo fromClass:(UIViewController *)view withImage: (UIImage *)image{
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp thirdButtonMethod:metodo fromClass:view withImage:image];

}

@end
