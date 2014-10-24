//
//  ExercisesList.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 11/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "ExercisesList.h"

#define exercisesCategoryCount 19

@implementation ExercisesList

+(ExercisesList *)sharedStore{
    static ExercisesList *sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
    
}

+(id) allocWithZone: (struct _NSZone *) zone{
    
    return [self sharedStore];
    
}

-(void)allocArrays {
    
    [self setExercisesMatrix:[NSMutableArray array]];
    
    for(int x = 0; x <= exercisesCategoryCount; x++) {
        [[self exercisesMatrix] addObject:[NSMutableArray array]];
    }
}


-(void)addExercise: (Exercises *)exercise inCategory: (NSString*)string {
    
    [[self getArrayForCategory:string] addObject:exercise];
    
}


-(NSMutableArray *)getArrayForCategory: (NSString *)string {
    
    if([string isEqualToString:@"fr_abdominal"]) {
        return [[self exercisesMatrix] objectAtIndex:1];
    }
    
    else if([string isEqualToString:@"fr_ante-braco"]) {
        return [[self exercisesMatrix] objectAtIndex:2];
    }
    
    else if([string isEqualToString:@"fr_biceps"]) {
        return [[self exercisesMatrix] objectAtIndex:3];
    }
    
    else if([string isEqualToString:@"fr_peitoral"]) {
        return [[self exercisesMatrix] objectAtIndex:4];
    }
    
    else if([string isEqualToString:@"fr_quadriceps"]) {
        return [[self exercisesMatrix] objectAtIndex:5];
    }
    else if([string isEqualToString:@"fr_ombros"]) {
        return [[self exercisesMatrix] objectAtIndex:6];
    }
    else if([string isEqualToString:@"fr_trapezio"]) {
        return [[self exercisesMatrix] objectAtIndex:7];
    }
    else if([string isEqualToString:@"fr_triceps"]) {
        return [[self exercisesMatrix] objectAtIndex:8];
    }
    else if([string isEqualToString:@"tr_ante-braco"]) {
        return [[self exercisesMatrix] objectAtIndex:9];
    }
    else if([string isEqualToString:@"tr_biceps"]) {
        return [[self exercisesMatrix] objectAtIndex:10];
    }
    else if([string isEqualToString:@"tr_dorsal"]) {
        return [[self exercisesMatrix] objectAtIndex:11];
    }
    else if([string isEqualToString:@"tr_gluteos"]) {
        return [[self exercisesMatrix] objectAtIndex:12];
    }
    else if([string isEqualToString:@"tr_lombar"]) {
        return [[self exercisesMatrix] objectAtIndex:13];
    }
    else if([string isEqualToString:@"tr_ombros"]) {
        return [[self exercisesMatrix] objectAtIndex:14];
    }
    else if([string isEqualToString:@"tr_panturrilha"]) {
        return [[self exercisesMatrix] objectAtIndex:15];
    }
    else if([string isEqualToString:@"tr_posterior-de-coxa"]) {
        return [[self exercisesMatrix] objectAtIndex:16];
    }
    else if([string isEqualToString:@"tr_romboides"]) {
        return [[self exercisesMatrix] objectAtIndex:17];
    }
    else if([string isEqualToString:@"tr_trapezio"]) {
        return [[self exercisesMatrix] objectAtIndex:18];
    }
    else if([string isEqualToString:@"tr_triceps"]) {
        return [[self exercisesMatrix] objectAtIndex:19];
    }
    
    else return nil;
}



@end
