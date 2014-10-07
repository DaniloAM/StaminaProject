//
//  Exercises.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 17/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "Exercises.h"


@implementation Exercises

@dynamic exerciseInfo;
@dynamic imageName;
@dynamic name;
@dynamic primaryMuscle;
@dynamic secondaryMuscle;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setPrimaryMuscle:[aDecoder decodeObjectForKey:@"exercise_pm"]];
        [self setSecondaryMuscle:[aDecoder decodeObjectForKey:@"exercise_sm"]];
        [self setExerciseInfo:[aDecoder decodeObjectForKey:@"exercise_in"]];
        [self setImageName:[aDecoder decodeObjectForKey:@"exercise_im"]];
        [self setName:[aDecoder decodeObjectForKey:@"exercise_na"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.primaryMuscle forKey:@"exercise_pm"];
    [aCoder encodeObject:self.secondaryMuscle forKey:@"exercise_sm"];
    [aCoder encodeObject:self.exerciseInfo forKey:@"exercise_in"];
    [aCoder encodeObject:self.imageName forKey:@"exercise_im"];
    [aCoder encodeObject:self.name forKey:@"exercise_na"];
    
}

@end
