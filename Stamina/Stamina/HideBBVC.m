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
    [self.view setBackgroundColor:[UIColor staminaYellowColor]];
}
-(CGPoint)pointStart{
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    
    return CGPointMake(0, self.navigationController.navigationBar.frame.size.height-temp.startSizeBar.height);
}
-(void)callViewWithName: (NSString *)string{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC= (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:string];
    [self.navigationController pushViewController:myVC animated:YES];
}
-(UIViewController   *)returnViewWithName: (NSString *)string{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC= (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:string];
    return myVC;
}
-(void)callView: (UIViewController *)view{
 
    [self.navigationController pushViewController:view  animated:YES];
}
-(void)viewWillAppear:(BOOL)animated withGesture: (BOOL)gesture{
    [super viewWillAppear:animated];
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    if(!gesture)
        [self.navigationController.view removeGestureRecognizer:[temp panLeft]];
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
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp panLeft].enabled = YES;


}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    for(UIView *view in [self.view subviews]){
        if([view isKindOfClass:[UIButton class]]||[view isKindOfClass:[UILabel class]]||[view isKindOfClass:[UITextField class]]){
            view.layer.cornerRadius = 7;
        }
            
    }
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
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
   
}
-(void)changeBarNameWith: (NSString *)str{
    [self.navigationItem setTitle:str];
}
-(void)firstButtonMethod: (void *)metodo fromClass:(UIViewController *)view withImage: (UIImage *)image{
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp firstButtonMethod:metodo fromClass:view withImage:image];
}
-(void)secondButtonMethod: (void *)metodo fromClass:(UIViewController *)view withImage: (UIImage *)image{
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp secondButtonMethod:metodo fromClass:view withImage:image];

}
-(void)addImage: (UIImage * )image toButton: (UIButton *)btn{
    for(UIView *vi in btn.subviews)
        [vi removeFromSuperview];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width*0.75, btn.frame.size.width*0.75)];

    [imageView setCenter:CGPointMake(btn.frame.size.width/2, btn.frame.size.height/2)];
    [imageView setImage:image];
    [btn addSubview:imageView];
}
-(void)thirdButtonMethod: (void *)metodo fromClass:(UIViewController *)view withImage: (UIImage *)image{
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
    [temp thirdButtonMethod:metodo fromClass:view withImage:image];

}
-(void)enableRightToBack{
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
}
-(void)enableRightToOpenMenu{
    JLSlideMenu *temp = [self.navigationController.viewControllers objectAtIndex:0];
}

@end
