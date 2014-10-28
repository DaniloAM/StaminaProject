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

@property UIPanGestureRecognizer *gesture;
@property int lastDirection;
-(void)viewWillAppear:(BOOL)animated withGesture: (BOOL)gesture;
-(NSArray *)criaBarButton;
-(void)showBar;
-(void)hideBar;
@end
