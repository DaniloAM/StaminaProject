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

#import <Foundation/Foundation.h>

@interface ExercisesList : NSObject

@property  NSMutableArray *biceps;
@property  NSMutableArray *abdomem;
@property  NSMutableArray *costas;
@property  NSMutableArray *triceps;
@property  NSMutableArray *outros;

+(ExercisesList *)sharedStore;
-(void)allocArrays;

@end
