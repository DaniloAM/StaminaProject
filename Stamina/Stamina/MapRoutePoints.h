//
//  MapRoutePoints.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 30/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MapRoutePoints : NSObject


@property NSMutableArray *arrayOfPointsX, *arrayOfPointsY;
@property double xMaxValue, xMinValue, yMaxValue, yMinValue;
@property CGRect frameForView, smallRouteFrame;


-(void)addPointToRouteInX: (double)pointX andY: (double)pointY;
-(UIImageView *)returnDrawedViewWithCurrentRoute;
-(void)prepareForCartesian;

@end
