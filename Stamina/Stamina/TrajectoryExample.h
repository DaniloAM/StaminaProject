//
//  TrajectoryExample.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 06/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TrajectoryExample : NSObject

@property int xMapPos;
@property int yMapPos;

@property UIImage *imageOnPoint;
@property BOOL *hasImage;

@property int routeID;
@property int pointNumber;
@property int totalPoints;

@property NSDate *date;

@property int distanceInMeters;
@property int seconds;
@property int minutes;
@property int calories;
@property int points;



@end
