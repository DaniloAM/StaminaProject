//
//  UserData.h
//  Projeto Final iOS Academia
//
//  Created by Danilo Augusto Mative on 25/07/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//
//---------------------------------------------------------------------//
//
//  This class has all the user data.
//
//  This class [trainingsArray] array is preloaded in the CoreDataLoading.
//
//  The other user info is loaded from UserDefaults.
//
//  The user basic info, trainings info and etc.
//
//  Every time a training is created, you need to call the method from this class.
//
//---------------------------------------------------------------------//
//

#import <Foundation/Foundation.h>
#import "TrainingExercises.h"
#import "AppDelegate.h"
#import "UserTraining.h"
#import "TrajectoryRoute.h"

@interface UserData : NSObject

@property NSMutableArray *trainingsArray;
@property NSMutableArray *routesArray;
@property NSString *name;
@property int heightInCentimeters;
@property int weightInKilograms;
@property int currentObjective;
@property int completedTrainings;
@property int bestSequence;
@property int currentSequence;
@property int userPoints;
@property int burnedCalories;
@property int lostWeight;
@property int initialWeight;
@property int groupID;
@property int userID;
@property int age;
@property BOOL sex;
@property NSString *lastTrainName;
@property NSDate *lastTrainDate, *startAppUse;
@property NSString *nickName;
@property NSString *email;
@property NSString *password;


-(void)clearTrainingFromCoreData;
+(UserData *)sharedStore;
-(NSArray *)returnTrainingWithName : (NSString *)trainingName;
-(void)removeTraning: (NSString *)trainingName;
-(void)addExerciseWithTrainingName: (NSString *)name exerciseID:(NSNumber *)exerciseID repetitionsValue: (NSNumber *)repetitionsValue seriesValue: (NSNumber *)seriesValue;
-(void)allocArray;

-(void)loadFromUserDefaults;
-(void)saveOnUserDefaults;

@end
