//
//  RoutePointsCartesian.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 08/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "RoutePointsCartesian.h"

@implementation RoutePointsCartesian

-(void)addPointToRouteInX: (double)pointX andY: (double)pointY {
    
    if(![self arrayOfPointsX]) {
        [self setArrayOfPointsX:[NSMutableArray array]];
        [self setArrayOfPointsY:[NSMutableArray array]];
    }
    
    [[self arrayOfPointsX] addObject:[NSNumber numberWithDouble:pointX]];
    [[self arrayOfPointsY] addObject:[NSNumber numberWithDouble:pointY]];
    
}

-(void)prepareForCartesian {
    
    [self setFrameForView:CGRectMake(0, 0, 180*3, 180*3)];
    
    if(![self arrayOfPointsX]) {
        return;
    }
    
    double xMin = [[[self arrayOfPointsX] firstObject] intValue];
    double xMax = [[[self arrayOfPointsX] firstObject] intValue];
    double yMin = [[[self arrayOfPointsY] firstObject] intValue];
    double yMax = [[[self arrayOfPointsY] firstObject] intValue];
    
    for(int x = 0; x < [[self arrayOfPointsX] count]; x++) {
        
        if([[[self arrayOfPointsX] objectAtIndex:x] doubleValue] < xMin) {
            xMin = [[[self arrayOfPointsX] objectAtIndex:x] doubleValue];
        }
        
        if([[[self arrayOfPointsX] objectAtIndex:x] doubleValue] > xMax) {
            xMax = [[[self arrayOfPointsX] objectAtIndex:x] doubleValue];
        }
        
        if([[[self arrayOfPointsY] objectAtIndex:x] doubleValue] < yMin) {
            yMin = [[[self arrayOfPointsY] objectAtIndex:x] doubleValue];
        }
        
        if([[[self arrayOfPointsY] objectAtIndex:x] doubleValue] > yMax) {
            yMax = [[[self arrayOfPointsY] objectAtIndex:x] doubleValue];
        }
        
    }
    
    _xMaxValue = xMax;
    _xMinValue = xMin;
    _yMaxValue = yMax;
    _yMinValue = yMin;
    
    
    double xSize = _xMaxValue - _xMinValue;
    double ySize = _yMaxValue - _yMinValue;
    double xFinal, yFinal, fator;
    
    
    if(xSize > ySize) {
        fator = ( _frameForView.size.width / xSize );
        
    } else {
        fator = ( _frameForView.size.height / ySize );
        
    }
    
    
    xFinal = xSize * fator;
    yFinal = ySize * fator;
    [self setSmallRouteFrame:CGRectMake(0, 0, xFinal, yFinal)];
    
    
    NSMutableArray *newArrayOfPointsX = [NSMutableArray array];
    NSMutableArray *newArrayOfPointsY = [NSMutableArray array];
    
    for(int x = 0; x < [[self arrayOfPointsX] count]; x++) {
        
        NSNumber *xNumber = [NSNumber numberWithDouble:
                             ( [[[self arrayOfPointsX] objectAtIndex:x] doubleValue] - _xMinValue ) / (_xMaxValue - _xMinValue)  * xFinal];
        
        NSNumber *yNumber = [NSNumber numberWithDouble:
                             ( [[[self arrayOfPointsY] objectAtIndex:x] doubleValue] - _yMinValue ) / (_yMaxValue - _yMinValue)  * yFinal];
        
        [newArrayOfPointsX addObject:xNumber];
        [newArrayOfPointsY addObject:yNumber];
        
    }
    
    [self setArrayOfPointsX:newArrayOfPointsX];
    [self setArrayOfPointsY:newArrayOfPointsY];
    
    
}

-(UIImageView *)returnDrawedViewWithCurrentRoute {
    
    if(![self arrayOfPointsX]) {
        return nil;
    }
    
    float lineSize = 15.0;
    
    _smallRouteFrame.size.width += lineSize * 2;
    _smallRouteFrame.size.height += lineSize * 2;
    
    UIImageView *routeView = [[UIImageView alloc] initWithFrame:_smallRouteFrame];
    
    UIGraphicsBeginImageContext(routeView.frame.size);
    [routeView.image drawInRect:CGRectMake(0, 0, routeView.frame.size.width, routeView.frame.size.height)];
    
    for(int x = 1; x < [[self arrayOfPointsX] count]; x++) {
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), [[[self arrayOfPointsX] objectAtIndex:x-1] doubleValue] + lineSize, [[[self arrayOfPointsY] objectAtIndex:x-1] doubleValue] + lineSize);
        
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), [[[self arrayOfPointsX] objectAtIndex:x] doubleValue] + lineSize, [[[self arrayOfPointsY] objectAtIndex:x] doubleValue] + lineSize);
        
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineSize);
        
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        
    }
    
    [routeView setImage:UIGraphicsGetImageFromCurrentImageContext()];
    
    
    return routeView;
}


@end
