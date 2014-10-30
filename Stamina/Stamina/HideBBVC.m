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

@end
