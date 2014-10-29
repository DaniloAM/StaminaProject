//
//  HideBBVC.h
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 09/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuShouldOpen.h"

@interface HideBBVC : UIViewController
@property UIView *tabBar;
@property CGPoint point;
@property CGPoint startPointBar;
-(NSArray *)criaBarButtonComBotoes: (int)n;
@property UIPanGestureRecognizer *gesture;
@property int lastDirection;
-(void)viewWillAppear:(BOOL)animated withGesture: (BOOL)gesture;
-(NSArray *)criaBarButtonComBotoesTranslucent: (int)n;
-(void)showBar;
-(void)hideBar;
-(void)adicionaImagem : (UIImage *)image paraOBotao : (UIButton *)btn;

@end
