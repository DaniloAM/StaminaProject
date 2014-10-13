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
        [new setWasDone:day.wasDone];
        [new setValidDay:day.validDay];
        [new setDateDone:day.dateDone];
        [new setDoneState:day.doneState];
        [new setHasTraining:day.hasTraining];
        [new setTrainingName:day.trainingName];
        [new setWeekdayNumber:day.weekdayNumber];
        
        [dayObjectsArray addObject:new];
        
    }
    
    [calendarObj addDayObjects:dayObjectsArray];
    
}


#pragma mark - Load Exercises

-(void)loadExercisesList {
    
    ExercisesList *list = [ExercisesList alloc];
    
    [list allocArrays];
    NSManagedObjectContext *context = [[self appdel] managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Exercises"];;
    NSError *error;
    
    NSArray *objectArray = [context executeFetchRequest:request error:&error];
    
    for(int x = 0; x < [objectArray count]; x++) {
        
        Exercises *exercise = [objectArray objectAtIndex:x];
        NSString *str = [exercise primaryMuscle];
        
        
        //If a new muscle array is created, you need to compare the new muscle name
        if([str isEqualToString:@"fr_abdominal"]) {
            [[list fr_abdominal] addObject:exercise];
        }
        
        else if([str isEqualToString:@"fr_ante-braco"]) {
            [[list fr_ante_braco] addObject:exercise];
        }
        
        else if([str isEqualToString:@"fr_biceps"]) {
            [[list fr_biceps] addObject:exercise];
        }
        
        else if([str isEqualToString:@"fr_peitoral"]) {
            [[list fr_peitoral] addObject:exercise];
        }
        
        else if([str isEqualToString:@"fr_quadriceps"]) {
            [[list fr_quadriceps] addObject:exercise];
        }
        else if([str isEqualToString:@"fr_ombros"]) {
            [[list fr_ombros] addObject:exercise];
        }
        else if([str isEqualToString:@"fr_trapezio"]) {
            [[list fr_trapezio] addObject:exercise];
        }
        else if([str isEqualToString:@"tr_ante-braco"]) {
            [[list tr_ante_braco] addObject:exercise];
        }
        else if([str isEqualToString:@"tr_biceps"]) {
            [[list tr_biceps] addObject:exercise];
        }
        else if([str isEqualToString:@"tr_dorsal"]) {
            [[list tr_dorsal] addObject:exercise];
        }
        else if([str isEqualToString:@"tr_gluteos"]) {
            [[list tr_gluteos] addObject:exercise];
        }
        else if([str isEqualToString:@"tr_lombar"]) {
            [[list tr_lombar] addObject:exercise];
        }
        else if([str isEqualToString:@"tr_gluteos"]) {
            [[list tr_gluteos] addObject:exercise];
        }
        else if([str isEqualToString:@"tr_ombros"]) {
            [[list tr_ombros] addObject:exercise];
        }
        else if([str isEqualToString:@"tr_panturrilha"]) {
            [[list tr_panturrilha] addObject:exercise];
        }
        else if([str isEqualToString:@"tr_posterior-de-coxa"]) {
            [[list tr_posterior_de_coxa] addObject:exercise];
        }
        else if([str isEqualToString:@"tr_romboides"]) {
            [[list tr_romboides] addObject:exercise];
        }
        else if([str isEqualToString:@"tr_trapezio"]) {
            [[list tr_trapezio] addObject:exercise];
        }
        else if([str isEqualToString:@"tr_triceps"]) {
            [[list tr_triceps] addObject:exercise];
        }
        

         
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
   
    [self addExerciseOnDatabaseWithName:@"exercicio 1" primMuscle:@"fr_abdominal" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 2" primMuscle:@"fr_ante-braco" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 3" primMuscle:@"fr_biceps" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 4" primMuscle:@"fr_peitoral" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 5" primMuscle:@"fr_quadriceps" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 6" primMuscle:@"fr_ombros" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 7" primMuscle:@"fr_trapezio" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 8" primMuscle:@"fr_triceps" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 8" primMuscle:@"tr_ante-braco" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 10" primMuscle:@"tr_biceps" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 11" primMuscle:@"tr_biceps" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 12" primMuscle:@"tr_dorsal" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 13" primMuscle:@"tr_gluteos" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 14" primMuscle:@"tr_lombar" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 15" primMuscle:@"tr_ombros" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 16" primMuscle:@"tr_panturrilha" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 17" primMuscle:@"tr_posterior-de-coxa" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 18" primMuscle:@"tr_romboides" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 19" primMuscle:@"tr_trapezio" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 20" primMuscle:@"tr_triceps" secMuscle:@"" image:@"" andInfo:@""];
    
}

-(void)addExerciseOnDatabaseWithName:(NSString *)name primMuscle: (NSString *)muscle1 secMuscle:
    (NSString *)muscle2 image: (NSString *)image andInfo: (NSString *)info  {
    

    NSManagedObjectContext *context = [[self appdel] managedObjectContext];
    
    Exercises *exercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercises" inManagedObjectContext:context];
    
    [exercise setName:name];
    [exercise setPrimaryMuscle:muscle1];
    [exercise setSecondaryMuscle:muscle2];
    [exercise setImageName:image];
    [exercise setExerciseInfo:info];
    
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
