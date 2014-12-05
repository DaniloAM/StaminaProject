//
//  TestUpdater.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 19/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "TestUpdater.h"

@implementation TestUpdater


-(NSArray *)currentNumberArray {
    
    return [super currentNumberArrayWithComponents:[self returnArrayOfComonents]];
}


-(NSArray *)nextNumberArray {
    
    return [super nextNumberArrayWithComponents:[self returnArrayOfComonents]];
}


-(NSArray *)previousNumberArray {
    
    return [super previousNumberArrayWithComponents:[self returnArrayOfComonents]];
}


-(void)expandGraphic {
    
    [self setNumberInView:7];
    [super expandGraphic];
    
}


-(void)contractGraphic {
    
    [self setNumberInView:4];
    [super contractGraphic];
}


-(NSMutableArray *)returnArrayOfComonents {
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *history = [TrajectoryHistory returnArrayOfTrajectoryFiles];
    
    for(int x = 0; x < [history count]; x++) {
        
        GNComponent *component = [[GNComponent alloc] init];
        component.GNDate = [[history objectAtIndex:x] dateDone];
        component.GraphicNumber = [[history objectAtIndex:x] distance];
        
        [array addObject:component];
    }
    
    return array;
}


@end
