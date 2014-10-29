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
<<<<<<< HEAD
-(void)adicionaImagem : (UIImage *)image paraOBotao : (UIButton *)btn{
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.height*0.85, btn.frame.size.height*0.85)];
    [image2  setImage:image];
    [btn setBackgroundColor:[UIColor    blackColor]];
    [btn addSubview:image2];
    [image2 setCenter:CGPointMake(btn.frame.size.width/2, btn.frame.size.height/2)];
    
}
-(void)mecheu :(UIPanGestureRecognizer *)sender{
    CGPoint velocity = [sender velocityInView:self.view];
    CGPoint stopLocation = [sender locationInView:self.view];
=======
>>>>>>> FETCH_HEAD


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
@end
