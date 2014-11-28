//
//  SaveTrainingCD.m
//  Stamina
//
//  Created by João Lucas Sisanoski on 19/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "SaveTrainingCD.h"

@implementation SaveTrainingCD
+(void)addExerciseToCoreDate: (ExerciseTemporary *)exe withTrainingName: (NSString *)str{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate ];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSError *error;
    TrainingExercises *tr = [NSEntityDescription insertNewObjectForEntityForName:@"TrainingExercise" inManagedObjectContext:context];
    [tr setTraining_name:str];
    [tr setRepetitions:[NSNumber numberWithInteger:[exe repeticoes]]];
    [tr setSeries:[NSNumber numberWithInteger:[exe serie]]];
    [tr setTime:[NSNumber numberWithInteger:[exe segundos]+[exe minutos]*60]];
    [tr setId_exercise:[[exe exercicio] exerciseID]];
    [context save:&error];
}
@end
