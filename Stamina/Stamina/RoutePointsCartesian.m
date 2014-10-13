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
    
    //Add points from map point.
    
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
    
    //Values to determine the minimum and maximum values for X and Y
    double xMin = [[[self arrayOfPointsX] firstObject] doubleValue];
    double xMax = [[[self arrayOfPointsX] firstObject] doubleValue];
    double yMin = [[[self arrayOfPointsY] firstObject] doubleValue];
    double yMax = [[[self arrayOfPointsY] firstObject] doubleValue];
    
    
    //Determines the maximums and minimums
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
    
    //Save them on the class
    _xMaxValue = xMax;
    _xMinValue = xMin;
    _yMaxValue = yMax;
    _yMinValue = yMin;
    
    
    //Calculete the size (diference between max and min)
    double xSize = _xMaxValue - _xMinValue;
    double ySize = _yMaxValue - _yMinValue;
    double xFinal, yFinal, fator;
    
    
    //The factor for resize the image based on the higher value
    if(xSize > ySize) {
        fator = ( _frameForView.size.width / xSize );
        
    } else {
        fator = ( _frameForView.size.height / ySize );
        
    }
    
    //Set the final frame for the image
    xFinal = xSize * fator;
    yFinal = ySize * fator;
    [self setSmallRouteFrame:CGRectMake(0, 0, xFinal, yFinal)];
    
    
    
    //Updates the array to the new system cartesian
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

-(UIImageView *)returnDrawedViewWithXArray:(NSMutableArray *)arrayOfX yArray: (NSMutableArray *)arrayOfY InSize: (CGSize)size {

    [self setArrayOfPointsX:arrayOfX];
    [self setArrayOfPointsY:arrayOfY];
    
    [self prepareForCartesian];
    
    UIImageView *routeImage = [self returnDrawedViewWithCurrentRoute];
    
    double fator;
    
    //Resize to the desired size passed in the function
    if(routeImage.frame.size.width > routeImage.frame.size.height) {
        fator = ( size.width / routeImage.frame.size.width );
        
    } else {
        fator = ( size.height / routeImage.frame.size.height );
        
    }
    
    [routeImage setFrame:CGRectMake(0, 0, routeImage.frame.size.width * fator , routeImage.frame.size.height * fator)];
    
    return routeImage;
    
}

-(UIImageView *)returnDrawedViewWithCurrentRoute {
    
    if(![self arrayOfPointsX] || [[self arrayOfPointsX] count] < 2) {
        return nil;
    }
    
    float lineSize = 15.0;
    
    /*  Increase the frame by the size of the line,
        so the line doesnt cross the frame limit.    */
    
    _smallRouteFrame.size.width += lineSize * 2;
    _smallRouteFrame.size.height += lineSize * 2;
    
    UIImageView *routeView = [[UIImageView alloc] initWithFrame:_smallRouteFrame];
    
    
    UIGraphicsBeginImageContext(routeView.frame.size);
    [routeView.image drawInRect:CGRectMake(0, 0, routeView.frame.size.width, routeView.frame.size.height)];
    
    
    //Draw the lines from point (A) to point (B)
    for(int x = 1; x < [[self arrayOfPointsX] count]; x++) {
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), [[[self arrayOfPointsX] objectAtIndex:x-1] doubleValue] + lineSize, [[[self arrayOfPointsY] objectAtIndex:x-1] doubleValue] + lineSize);
        
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), [[[self arrayOfPointsX] objectAtIndex:x] doubleValue] + lineSize, [[[self arrayOfPointsY] objectAtIndex:x] doubleValue] + lineSize);
        
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineSize);
        
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        
    }
    
    //Set the image of the view
    [routeView setImage:UIGraphicsGetImageFromCurrentImageContext()];
    
    //Restore old size of frame
    _smallRouteFrame.size.width -= lineSize * 2;
    _smallRouteFrame.size.height -= lineSize * 2;
    
    return routeView;
}


@end
