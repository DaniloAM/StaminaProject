//
//  Exercises.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 17/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//
//---------------------------------------------------------------------//
//
//  Exercises class for entity in CoreData.
//
//---------------------------------------------------------------------//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Exercises : NSManagedObject

@property (nonatomic, retain) NSString * exerciseInfo;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * primaryMuscle;
@property (nonatomic, retain) NSString * secondaryMuscle;

@end
