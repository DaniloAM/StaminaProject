//
//  TrajectoryObject.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 06/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TrajectoryObject : NSObject

@property NSMutableArray *arrayOfPoints;
@property NSMutableArray *arrayOfImages;

@property UIImage *userImage;

@property NSDate *dateCreated;
@property float distanceInMeters;
@property int timeInSeconds, timeInMinutes, calories;

@end
