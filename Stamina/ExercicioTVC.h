//
//  ExercicioTVC.h
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 13/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "HideBBVC.h"
#import "ExercisesList.h"
#import "Exercises.h"
@interface ExercicioTVC : HideBBVC <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
@property NSArray *arrayOfExercises;
@property UITableView *table;
@property float lastContentOffset;
@end
