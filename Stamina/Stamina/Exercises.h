//
//  Exercises.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 23/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Exercises : NSManagedObject

@property (nonatomic, retain) NSNumber * exerciseID;
@property (nonatomic, retain) NSString * exerciseInfo;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * primaryMuscle;
@property (nonatomic, retain) NSString * secondaryMuscle;

@end
