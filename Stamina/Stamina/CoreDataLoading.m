//
//  CoreDataLoading.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 11/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//


#import "CoreDataLoading.h"

@implementation CoreDataLoading


-(void)initCoreData{
    [self setAppdel:[[UIApplication sharedApplication] delegate]];
    
    if(![self checkExercisesOnDatabase]) {
        [self createExerciseDatabase];
    }
    
    [self loadExercisesList];
    [self loadCalendarInfo];
    [self loadTrainingsAndRoutesCreated];
}
#pragma mark - Load Calendar


-(void)loadCalendarInfo {
    
    CalendarObject *calendarObj = [CalendarObject alloc];
    
    NSManagedObjectContext *context = [[self appdel] managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TrainingDayObject"];
    NSError *error;
    
    NSArray *objectArray = [context executeFetchRequest:request error:&error];
    
    NSMutableArray *dayObjectsArray = [NSMutableArray array];
    
    for(int x = 0; x < [objectArray count]; x++) {
        
        TrainingDayObject *day = [objectArray objectAtIndex:x];
        DayObject *new = [[DayObject alloc] init];
        
        [new setDate:day.date];
        [new setDateDone:day.dateDone];
        [new setDoneState:day.doneState];
        [new setHasTraining:day.hasTraining];
        [new setTrainingName:day.trainingName];
        
        [dayObjectsArray addObject:new];
        
    }
    
    [calendarObj addDayObjects:dayObjectsArray];
    
}


#pragma mark - Load Exercises


-(void)loadExercisesList {
    
    ExercisesList *list = [ExercisesList alloc];
    
    [list allocArrays];
    NSManagedObjectContext *context = [[self appdel] managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exercises"];
    NSError *error;
    
    NSArray *objectArray = [context executeFetchRequest:request error:&error];
    
    for(int x = 0; x < [objectArray count]; x++) {
        
        Exercises *exercise = [objectArray objectAtIndex:x];
        
        [list addExercise:exercise inCategory:exercise.primaryMuscle];
         
    }

}

#pragma mark - Load Trainings

-(void)loadTrainingsAndRoutesCreated {
    
    UserData *data = [UserData alloc];
    [data allocArray];
    
    NSManagedObjectContext *context = [[self appdel] managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TrainingExercises"];
    NSError *error;
    
    NSArray *exercisesArray = [context executeFetchRequest:request error:&error];
    
    for(int x = 0; x < [exercisesArray count]; x++) {
        
        TrainingExercises *training = [exercisesArray objectAtIndex:x];
        [[data trainingsArray] addObject:training];
        
    }
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"TrajectoryRoute"];
    NSArray *routesArray = [context executeFetchRequest:request error:&error];
    
    for(int x = 0; x < [routesArray count]; x++) {
        
        TrajectoryRoute *route = [routesArray objectAtIndex:x];
        [[data routesArray] addObject:route];
        
    }
    
    
    
}

#pragma mark - Create Exercise Database

-(void)createExerciseDatabase {
    for(int x = 0; x < 10 ; x++){
        
        
        NSString *str = [CalendarMath returnMonthName:x+1];
        
        
        [NSString stringWithFormat:@"exercicio %@", str];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"fr_abdominal" secMuscle:@"" image:@"" info:@"" andID:101000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"fr_ante-braco" secMuscle:@"" image:@"" info:@"" andID:102000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"fr_biceps" secMuscle:@"" image:@"" info:@"" andID:103000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"fr_peitoral" secMuscle:@"" image:@"" info:@"" andID:104000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"fr_quadriceps" secMuscle:@"" image:@"" info:@"" andID:105000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"fr_ombros" secMuscle:@"" image:@"" info:@"" andID:106000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"fr_trapezio" secMuscle:@"" image:@"" info:@"" andID:107000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"fr_triceps" secMuscle:@"" image:@"" info:@"" andID:108000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"tr_ante-braco" secMuscle:@"" image:@"" info:@"" andID:109000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"tr_biceps" secMuscle:@"" image:@"" info:@"" andID:110000 + (x + 2)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"tr_biceps" secMuscle:@"" image:@"" info:@"" andID:110000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"tr_dorsal" secMuscle:@"" image:@"" info:@"" andID:111000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"tr_gluteos" secMuscle:@"" image:@"" info:@"" andID:112000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"tr_lombar" secMuscle:@"" image:@"" info:@"" andID:113000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"tr_ombros" secMuscle:@"" image:@"" info:@"" andID:114000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"tr_panturrilha" secMuscle:@"" image:@"" info:@"" andID:115000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"tr_posterior-de-coxa" secMuscle:@"" image:@"" info:@"" andID:116000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"tr_romboides" secMuscle:@"" image:@"" info:@"" andID:117000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"tr_trapezio" secMuscle:@"" image:@"" info:@"" andID:118000 + (x + 1)];
        
        [self addExerciseOnDatabaseWithName:[NSString stringWithFormat:@"exercicio %@ %d", str, x] primMuscle:@"tr_triceps" secMuscle:@"" image:@"" info:@"" andID:119000 + (x + 1)];
    }
}

-(void)addExerciseOnDatabaseWithName:(NSString *)name primMuscle: (NSString *)muscle1 secMuscle:
(NSString *)muscle2 image: (NSString *)image info: (NSString *)info andID: (int)identifier {
    

    NSManagedObjectContext *context = [[self appdel] managedObjectContext];
    
    Exercises *exercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercises" inManagedObjectContext:context];
    
    [exercise setName:name];
    [exercise setPrimaryMuscle:muscle1];
    [exercise setSecondaryMuscle:muscle2];
    [exercise setImageName:image];
    [exercise setExerciseInfo:info];
    [exercise setExerciseID:[NSNumber numberWithInt:identifier]];
    
    NSError *error;
    
    [context save:&error];
    
}


-(BOOL)checkExercisesOnDatabase {
    
    NSError *error;
    NSManagedObjectContext *context = [[self appdel] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Exercises" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    
    if([objects count] == 0) {
        return false;
    }
    
    else return true;
}

@end
