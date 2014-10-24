//
//  ExercisesList.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 11/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//
//---------------------------------------------------------------------//
//
//  This class is a list of all exercises that we have in our database.
//
//  This class is pre-loaded in the CoreDataLoading and is for ** reference-only **.
//
//  It separates in muscle arrays and the array outros.
//
//  If a new muscle array is created, you need to alloc it in allocArrays
//
//---------------------------------------------------------------------//
//
// frontal abdominal - 001
// frontal ante braco - 002
// frontal biceps - 003
// frontal peitoral - 004
// frontal quadriceps - 005
// frontal ombros - 006
// frontal trapezio - 007
// frontal triceps - 008
// trazeiro ante braco - 009
// trazeiro biceps - 010
// trazeiro dorsal - 011
// trazeiro gluteos - 012
// trazeiro lombar - 013
// trazeiro ombros - 014
// trazeiro panturrilha - 015
// trazeiro posterior oxa - 016
// trazeiro romboides - 017
// trazeiro trapezio - 018
// trazeiro triceps - 019

#import <Foundation/Foundation.h>
#import "Exercises.h"

@interface ExercisesList : NSObject

@property NSMutableArray *exercisesMatrix;

-(void)addExercise: (Exercises *)exercise inCategory: (NSString*)string;
-(NSMutableArray *)getArrayForCategory: (NSString *)string;
+(ExercisesList *)sharedStore;
-(void)allocArrays;

@end
