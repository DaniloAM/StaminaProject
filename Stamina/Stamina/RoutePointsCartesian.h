//
//  RoutePointsCartesian.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 08/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RoutePointsCartesian : NSObject


@property NSMutableArray *arrayOfPointsX, *arrayOfPointsY;
@property double xMaxValue, xMinValue, yMaxValue, yMinValue;
@property CGRect frameForView, smallRouteFrame;


-(void)addPointToRouteInX: (double)pointX andY: (double)pointY;
-(UIImageView *)returnDrawedViewWithCurrentRoute;
-(void)prepareForCartesian;

@end
