//
//  ExerciseToAddVC.h
//  Stamina
//
//  Created by João Lucas Sisanoski on 07/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "HideBBVC.h"

@interface ExerciseToAddVC : HideBBVC
@property UIImageView *gifExplain;
@property UIButton *cronometer, *repetitions;
@property UILabel *exerciseName, *categoriaName, *x;
@property UITextField *txtSer, *txtRep, *txtTime;
@property BOOL selected;
@property UIView *view1, *viewAux1, *viewAux2, *cronometerView, *repetitionView;
@end
