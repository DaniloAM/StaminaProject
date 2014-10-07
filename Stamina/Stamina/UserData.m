//
//  UserData.m
//  Projeto Final iOS Academia
//
//  Created by Danilo Augusto Mative on 25/07/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "UserData.h"

@implementation UserData

+(UserData *)sharedStore{
    static UserData *sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
    
}
+(id) allocWithZone: (struct _NSZone *) zone{
    
    return [self sharedStore];
    
}

//exercise_id index 0
//repetitions index 1
//series index 2

-(void)addExerciseWithTrainingName: (NSString *)name exerciseID:(NSNumber *)exerciseID repetitionsValue: (NSNumber *)repetitionsValue seriesValue: (NSNumber *)seriesValue{

    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    
    NSError *error;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TrainingExercises"];
    NSArray *array = [context executeFetchRequest:request error:&error];
    for (int x = 0 ; x < [array count]; x++){
        TrainingExercises* ex = [array objectAtIndex:x];

        NSLog(@"id exercise no meio do for %@", [ex id_exercise]);
        
        if([[ex training_name] isEqualToString:name] && [[ex id_exercise] integerValue]==[exerciseID integerValue] && [[ex series] integerValue]==[seriesValue integerValue] && [[ex repetitions] integerValue]==[repetitionsValue integerValue]) {
            return;
        }
    }
        TrainingExercises *exercise = [NSEntityDescription insertNewObjectForEntityForName:@"TrainingExercises" inManagedObjectContext:context];
        
        
        [exercise setTraining_name:name];
        NSLog(@"esta no fim do metodo %@", exerciseID);
        [exercise setId_exercise:exerciseID];
        [exercise setRepetitions:repetitionsValue];
        [exercise setSeries:seriesValue];
        
    
        [context save:&error];
}
-(void)clearTrainingFromCoreData{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *myContext = [app managedObjectContext];
    NSFetchRequest * allCars = [[NSFetchRequest alloc] init];
    [allCars setEntity:[NSEntityDescription entityForName:@"TrainingExercises" inManagedObjectContext:myContext]];
    [allCars setIncludesPropertyValues:NO];
    
    NSError * error = nil;
    NSArray * cars = [myContext executeFetchRequest:allCars error:&error];
    //error handling goes here
    for (NSManagedObject * car in cars) {
        [myContext deleteObject:car];
    }
    NSError *saveError = nil;
    [myContext save:&saveError];
}
-(NSArray *)returnTrainingWithName : (NSString *)trainingName{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:trainingName];
    NSError *error = nil;
    return [context executeFetchRequest:request error:&error];
}
-(void)removeTraning: (NSString *)trainingName {
    
    BOOL success = false;
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Trainings"];
    
    NSError *error = nil;
    
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    for(NSManagedObject *obj in array) {
        
        if ([[obj valueForKey:@"name"] isEqualToString:trainingName]) {
            
            success = true;
            
            [context deleteObject:obj];
            break;
        }
    }
    
    if(!success) {
        NSLog(@"Erro. Treino não encontrado.");
    }
    
}

-(void)allocArray {
    [self setTrainingsArray:[NSMutableArray array]];
}

-(void)saveOnUserDefaults {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    
    [defaults setInteger:[self currentObjective] forKey:@"ud_co"];
    [defaults setInteger:[self completedTrainings] forKey:@"ud_ct"];
    
    [defaults setInteger:[self age] forKey:@"ud_age"];
    [defaults setInteger:[self initialWeight] forKey:@"ud_initialweight"];
    [defaults setInteger:[self weightInKilograms] forKey:@"ud_weight"];
    [defaults setInteger:[self heightInCentimeters] forKey:@"ud_height"];
    
    [defaults setBool:[self sex] forKey:@"ud_sex"];
    
    [defaults setObject:[self startAppUse] forKey:@"ud_sap"];
    [defaults setObject:[self password] forKey:@"ud_pass"];
    [defaults setObject:[self nickName] forKey:@"ud_nickname"];
    [defaults setObject:[self email] forKey:@"ud_email"];
    [defaults setObject:[self name] forKey:@"ud_name"];
 
    
    
    [defaults synchronize];
    
}

-(void)loadFromUserDefaults {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    _name = [defaults objectForKey:@"ud_name"];
    _currentObjective = (int)[defaults integerForKey:@"ud_co"];
    _completedTrainings = (int)[defaults integerForKey:@"ud_ct"];
    _startAppUse = [defaults objectForKey:@"ud_sap"];
    _email = [defaults objectForKey:@"ud_email"];
    _nickName = [defaults objectForKey:@"ud_nickname"];
    _password = [defaults objectForKey:@"ud_pass"];
    
    _initialWeight = (int)[defaults integerForKey:@"ud_initialweight"];
    _heightInCentimeters = (int)[defaults integerForKey:@"ud_weight"];
    _initialWeight = (int)[defaults integerForKey:@"ud_height"];
    _sex  = [defaults boolForKey:@"ud_sex"];
    _age  = (int)[defaults integerForKey:@"ud_age"];
    
    
}


@end
