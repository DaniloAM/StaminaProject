//
//  RunningRoute.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 30/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapRoutePoints.h"

@interface RunningRoute : NSObject

@property float distanceInMeters;
@property int timeInSeconds, timeInMinutes;
@property MapRoutePoints *routePoints;
@property NSMutableArray *arrayOfSpeeds;

@end
