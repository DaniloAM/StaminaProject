//
//  HideBBVC.h
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 09/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuShouldOpen.h"
#import "JLSlideMenu.h"
#import "ExercisesList.h"
#import "UIStaminaImages.h"
@interface HideBBVC : UIViewController <UITextFieldDelegate>
@property UIView *tabBar;

@property int lastDirection;
-(void)viewWillAppear:(BOOL)animated withGesture: (BOOL)gesture;
-(void)showBarWithAnimation: (BOOL)animation;
-(void)hideBarWithAnimation: (BOOL)animation;
-(CGSize)navigationSize;
-(CGSize)tabBarSize;
-(void)firstButtonMethod: (void *)metodo fromClass:(UIViewController *)view withImage: (UIImage *)image;
-(void)secondButtonMethod: (void *)metodo fromClass:(UIViewController *)view withImage: (UIImage *)image;
-(void)thirdButtonMethod: (void *)metodo fromClass:(UIViewController *)view withImage: (UIImage *)image;
-(void)enableRightToBack;
-(CGPoint)pointStart;
-(void)enableRightToOpenMenu;
-(void)callViewWithName: (NSString *)string;
-(void)changeBarNameWith: (NSString *)str;
-(void)callView: (UIViewController *)view;
-(UIViewController *)returnViewWithName: (NSString *)string;
-(void)addImage: (UIImage * )image toButton: (UIButton *)btn;
@end
