//
//  HideBBVC.h
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 09/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuShouldOpen.h"
#import "MenuVC.h"
@interface HideBBVC : UIViewController
@property UIView *tabBar;

@property int lastDirection;
-(void)viewWillAppear:(BOOL)animated withGesture: (BOOL)gesture;
-(NSArray *)buttons;
-(NSArray *)criaBarButton;
-(void)showBarWithAnimation: (BOOL)animation;
-(void)hideBarWithAnimation: (BOOL)animation;
-(void) removeGestureFromMenuVC;
-(CGSize)navigationSize;
-(CGSize)navigationIncreased;
-(CGSize)navigationStartSize;
-(CGSize)tabBarSize;

-(void)firstButtonMethod: (void *)metodo  withImage: (UIImage *)image;
-(void)secondButtonMethod: (void *)metodo  withImage: (UIImage *)image;
-(void)thirdButtonMethod: (void *)metodo  withImage: (UIImage *)image;
-(void)enableRight;
-(void)disableRight;
@end
