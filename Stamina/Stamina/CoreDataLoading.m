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
    [self loadTrainingsCreated];
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
        if([str isEqualToString:@"costas"]) {
            [[list costas] addObject:exercise];
        }
        
        else if([str isEqualToString:@"abdomem"]) {
            [[list abdomem] addObject:exercise];
        }
        
        else if([str isEqualToString:@"triceps"]) {
            [[list triceps] addObject:exercise];
        }
        
        else if([str isEqualToString:@"biceps"]) {
            [[list biceps] addObject:exercise];
        }
        
        else {
            [[list outros] addObject:exercise];
        }
         
    }

}

#pragma mark - Load Trainings

-(void)loadTrainingsCreated {
    
    UserData *data = [UserData alloc];
    
    [data allocArray];
    
    NSManagedObjectContext *context = [[self appdel] managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TrainingExercises"];
    NSError *error;
    
    NSArray *objectArray = [context executeFetchRequest:request error:&error];
    
    for(int x = 0; x < [objectArray count]; x++) {
        
        TrainingExercises *training = [objectArray objectAtIndex:x];
        
        
        [[data trainingsArray] addObject:training];
    }
    
}

#pragma mark - Create Exercise Database

-(void)createExerciseDatabase {
   
    [self addExerciseOnDatabaseWithName:@"exercicio 1" primMuscle:@"costas" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 2" primMuscle:@"biceps" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 3" primMuscle:@"triceps" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 4" primMuscle:@"costas" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 5" primMuscle:@"abdomem" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 6" primMuscle:@"abdomem" secMuscle:@"" image:@"" andInfo:@""];
    
    [self addExerciseOnDatabaseWithName:@"exercicio 7" primMuscle:@"abdomem" secMuscle:@"" image:@"" andInfo:@""];
    
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
