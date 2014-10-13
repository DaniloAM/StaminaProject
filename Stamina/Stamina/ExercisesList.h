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

@property NSMutableArray *fr_abdominal, *fr_ante_braco, *fr_biceps, *fr_peitoral, *fr_quadriceps, *fr_ombros, *fr_trapezio, *fr_triceps;
@property NSMutableArray *tr_ante_braco, *tr_biceps, *tr_dorsal, *tr_gluteos, *tr_lombar, *tr_ombros, *tr_panturrilha, *tr_posterior_de_coxa, *tr_romboides, *tr_trapezio, *tr_triceps;
+(ExercisesList *)sharedStore;
-(void)allocArrays;

@end
