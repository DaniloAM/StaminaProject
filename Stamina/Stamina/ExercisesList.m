//
//  ExercisesList.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 11/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "ExercisesList.h"


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
+(NSString *)returnCategoryNameWithId :(int )identifier{
    int index = (identifier / 1000);
    switch (index) {
        case 101:
            return @"Frontal - Abdominal";
            break;
        case 102:
            return @"Frontal - Ante-Braço";
            break;
        case 103:
            return @"Frontal - Biceps";
            break;
        case 104:
            return @"Frontal - Peitoral";
            break;
        case 105:
            return @"Frontal - Quadríceps";
            break;
        case 106:
            return @"Frontal - Ombros";
            break;
        case 107:
            return @"Frontal - Trapezio";
            break;
        case 108:
            return @"Frontal - Triceps";
            break;
        case 109:
            return @"Traseiro - Ante-Braço";
            break;
        case 110:
            return @"Traseiro - Biceps";
            break;
        case 111:
            return @"Traseiro - Dorsal";
            break;
        case 112:
            return @"Traseiro - Glúteos";
            break;
        case 113:
            return @"Traseiro - Lombar";
            break;
        case 114:
            return @"Traseiro - Ombros";
            break;
        case 115:
            return @"Traseiro - Panturrilha";
            break;
        case 116:
            return @"Traseiro - Posterior de Coxa";
            break;
        case 117:
            return @"Traseiro - Rombóides";
            break;
        case 118:
            return @"Traseiro - Trapézio";
            break;
        case 119:
            return @"Traseiro - Triceps";
            break;
            
        default:
            break;
    }
    return nil;
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



-(Exercises *)returnExerciseWithIdentifier: (int)identifier {
    
    int index = (identifier / 1000) - 100;
    
    for(Exercises *ex in [[self exercisesMatrix] objectAtIndex:index]) {
        
        if(ex.exerciseID.intValue == identifier) {
            
            return ex;
            
        }
        
    }
    
    return nil;
}



@end
