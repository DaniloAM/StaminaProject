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
    [self setTr_ante_braco:[NSMutableArray array]];
    [self setTr_biceps:[NSMutableArray array]];
    [self setTr_dorsal:[NSMutableArray array]];
    [self setTr_gluteos:[NSMutableArray array]];
    [self setTr_lombar:[NSMutableArray array]];
    [self setTr_ombros:[NSMutableArray array]];
    [self setTr_panturrilha:[NSMutableArray array]];
    [self setTr_posterior_de_coxa:[NSMutableArray array]];
    [self setTr_romboides:[NSMutableArray array]];
    [self setTr_trapezio:[NSMutableArray array]];
    [self setTr_triceps:[NSMutableArray array]];
    [self setFr_abdominal:[NSMutableArray array]];
    [self setFr_ante_braco:[NSMutableArray array]];
    [self setFr_biceps:[NSMutableArray array]];
    [self setFr_ombros:[NSMutableArray array]];
    [self setFr_peitoral:[NSMutableArray array]];
    [self setFr_quadriceps:[NSMutableArray array]];
    [self setFr_trapezio:[NSMutableArray array]];
    [self setFr_triceps:[NSMutableArray array]];

}

@end
