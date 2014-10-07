//
//  TrainingExercises.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 17/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TrainingExercises : NSManagedObject

@property (nonatomic, retain) NSNumber * id_exercise;
@property (nonatomic, retain) NSNumber * repetitions;
@property (nonatomic, retain) NSNumber * series;
@property (nonatomic, retain) NSString * training_name;

@end
