//
//  SaveTrainingCD.h
//  Stamina
//
//  Created by João Lucas Sisanoski on 19/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExerciseTemporary.h"
#import "TrainingExercises.h"
#import "AppDelegate.h"
@interface SaveTrainingCD : NSObject
+(void)addExerciseToCoreDate: (ExerciseTemporary *)exe withTrainingName: (NSString *)str;
@end
