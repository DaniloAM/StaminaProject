//
//  JLSlideMenu.h
//  Stamina
//
//  Created by João Lucas Sisanoski on 07/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIStaminaColor.h"
#import "MenuLViews.h"
@interface JLSlideMenu : UIViewController
typedef enum gestureRecognizedTypes
{   LEFT,
    RIGHT,
    UP,
    DOWN,
    VERTICAL,
    HORIZONTAL,
    UNDEFINED
} GestureRecognized;
@property NSArray *arrayOfViewsControllers;
@property UIView *leftMenu;
@property UIPanGestureRecognizer *panLeft;
@property int recognized, direction;
@property CGPoint firstTouch;
@property float leftWidthSize, tabHeightSize;
@property NSMutableArray *arrayOfViews;
@property UIView *tabBar;
@property NSArray *arrayOfButtons;
@property BOOL menuOpen;
@property int open;
@property NSArray *arrayFirstButton;
@property NSArray *secondFirstButton;
@property NSArray *thirdFirstButton;
@property NSArray *fourthFirstButton;
@property UIViewController *presenting;
@property NSArray *arrayTabBar;
@property BOOL shouldRecognizeRight;
@property BOOL stop;
-(void)showBarWithAnimation : (BOOL)animated;
-(void)hideBarWithAnimation : (BOOL)animated;
-(void)firstButtonMethod: (void *)metodo fromClass:(UIViewController *)view  withImage: (UIImage *)image;
-(void)secondButtonMethod: (void *)metodo fromClass:(UIViewController *)view withImage: (UIImage *)image;
-(void)thirdButtonMethod: (void *)metodo  fromClass:(UIViewController *)view withImage: (UIImage *)image;
-(void)hideLeftMenuAnimated: (BOOL)animated;
-(void)cleanButtons;

@end
