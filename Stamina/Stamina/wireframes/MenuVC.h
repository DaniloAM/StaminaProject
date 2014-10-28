//
//  MenuVC.h
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 09/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSlideMenuMainViewController.h"

@interface MenuVC : UIViewController
-(NSArray *)criaBarButton;
@property UIView *tab;
@property CGPoint point;
@property CGPoint startPointBar;
@property NSArray *arrayOfButtons;
@property UIPanGestureRecognizer *gesture;

-(void)cleanAllBtn;
-(void)showBar;
-(void)hideBar;
@property int lastDirection;

-(void)viewWillAppear:(BOOL)animated withGesture: (BOOL)gesture;
@end
