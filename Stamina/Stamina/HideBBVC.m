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
 [self.view setUserInteractionEnabled:NO];
    
}
-(void)viewWillAppear:(BOOL)animated withGesture: (BOOL)gesture{
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
    MenuShouldOpen  *menu = [MenuShouldOpen alloc];
    [menu setOpen:NO];
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp cleanAllBtn];
    [temp right].enabled = NO;
    [temp gesture].enabled = NO;
    [temp tab].userInteractionEnabled = NO;
    
}

-(void)moveView: (UIView *)bigView withPoint: (CGPoint )point withDuration: (float)duration{
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:duration];
    bigView.frame = CGRectMake(point.x, point.y, bigView.frame.size.width, bigView.frame.size.height);
    [UIView commitAnimations];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    MenuShouldOpen *menu = [MenuShouldOpen alloc];
    [menu setOpen:YES];
    [super viewWillDisappear:animated];
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp setLastDirection:-1];
    [temp right].enabled = NO;
    [temp gesture].enabled = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
        [self.view setUserInteractionEnabled:YES];
        MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
        [temp tab].userInteractionEnabled = YES;
    [temp right].enabled = YES;
    [temp gesture].enabled = YES;
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view resignFirstResponder];
    [self.view endEditing:YES];

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
-(void)enableRight{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp enableRight];
}
-(void)disableRight{
    MenuVC *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp disableRight];
}
@end
