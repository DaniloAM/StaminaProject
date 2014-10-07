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
    
    [self setBiceps:[NSMutableArray array]];
    [self setAbdomem:[NSMutableArray array]];
    [self setCostas:[NSMutableArray array]];
    [self setTriceps:[NSMutableArray array]];
    [self setOutros:[NSMutableArray array]];
    
}

@end
