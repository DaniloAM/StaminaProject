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
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [self setTabBar:[temp tab]];
}
-(void)voltaView{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
 
}
-(void)viewWillAppear:(BOOL)animated withGesture: (BOOL)gesture{
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
    MenuShouldOpen  *menu = [MenuShouldOpen alloc];
    [menu setOpen:NO];
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp cleanAllBtn];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    MenuShouldOpen *menu = [MenuShouldOpen alloc];
    [menu setOpen:YES];
    [super viewWillDisappear:animated];
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp setLastDirection:-1];
}

-(NSArray *)criaBarButton{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    return [temp arrayOfButtons];
}


-(void)hideBar{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp hideBarWithAnimation:YES];

}
-(void)showBarWithAnimation: (BOOL)animation{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp showBarWithAnimation:YES];
}
-(void)hideBarWithAnimation: (BOOL)animation{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp hideBarWithAnimation:YES];
}

-(void) removeGestureFromMenuVC{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp removeGestureFromMenuVC];
    
}
-(NSArray *)buttons{
     MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    return [temp arrayOfButtons];
}
-(CGSize)navigationSize{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    return [temp navigationSize];
}
-(CGSize)navigationIncreased{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    return [temp navigationIncreased];
}
-(CGSize)navigationStartSize{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    return [temp navigationStartSize];
}
-(void)firstButtonMethod: (void *)metodo withImage: (UIImage *)image{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    UIButton *btn = [[temp arrayOfButtons] firstObject];
    [temp firstButtonMethod:nil withImage:image];
    [btn addTarget:self action:metodo forControlEvents:UIControlEventTouchUpInside];

}
-(void)secondButtonMethod: (void *)metodo  withImage: (UIImage *)image{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    UIButton *btn = [[temp arrayOfButtons] objectAtIndex:1];
    [temp secondButtonMethod:nil withImage:image];
    [btn addTarget:self action:metodo forControlEvents:UIControlEventTouchUpInside];
}
-(void)thirdButtonMethod: (void *)metodo  withImage: (UIImage *)image{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    UIButton *btn = [[temp arrayOfButtons] lastObject];
    [temp thirdButtonMethod:nil withImage:image];
    [btn addTarget:self action:metodo forControlEvents:UIControlEventTouchUpInside];
}

@end
