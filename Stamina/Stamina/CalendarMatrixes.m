//
//  CalendarMatrixes.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 12/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CalendarMatrixes.h"

@implementation CalendarMatrixes


-(id)initWithCalendarPositionsX: (int)xPos Y: (int)yPos Xsize: (int)xSize Ysize: (int)ySize  spacement: (int)spc fontSize: (float)fontSize fontColor: (UIColor *)color {
    self = [super init];
    
    if(self) {
        
        _startXPos = xPos;
        _startYPos = yPos;
        _XSize = xSize;
        _YSize = ySize;
        _fontSize = fontSize;
        _spacement = spc;
        _fontColor = color;
        
    }
    
    return self;
}


-(NSMutableArray *)getLabelMatrixForCalendar {
    
    NSMutableArray *labelArray = [NSMutableArray array];
    
    for(int x = 0; x < 7; x++) {
        [labelArray addObject:[NSMutableArray array]];
    }
    
    int xPos = _startXPos, yPos = _startYPos;
    
    for(int x=0;x<6;x++) {
        
        for(int y=0;y<7;y++) {
            
            UILabel *label = [[UILabel alloc] init];
            
            [label setFrame:CGRectMake(xPos, yPos, _XSize, _YSize)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setText:@""];
            [label setTextColor:_fontColor];
            
            [[labelArray objectAtIndex:y] addObject:label];
            
            xPos += _XSize + _spacement;
        }
        
        xPos = _startXPos;
        yPos += _YSize + _spacement;
    }
    
    return labelArray;
    
}


-(NSMutableArray *)getButtonMatrixForCalendar {
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    
    for(int x = 0; x < 7; x++) {
        [buttonArray addObject:[NSMutableArray array]];
    }
    
    int xPos = _startXPos, yPos = _startYPos;
    
    for(int x=0;x<6;x++) {
        
        for(int y=0;y<7;y++) {
            
            UIButton *button = [[UIButton alloc] init];
            
            [button setFrame:CGRectMake(xPos, yPos, _XSize, _YSize)];
            
            [[buttonArray objectAtIndex:y] addObject:button];
            
            xPos += _XSize + _spacement;
        }
        
        xPos = _startXPos;
        yPos += _YSize + _spacement;
    }
    
    return buttonArray;
    
}


-(NSMutableArray *)getDayObjectMatrixCalendarForMonth: (int)month andYear: (int)year {
    
    CalendarMath *math = [[CalendarMath alloc] init];
    NSMutableArray *dayArray = [NSMutableArray array];
    
    for(int x = 0; x < 7; x++) {
        [dayArray addObject:[NSMutableArray array]];
    }
    
    int indexWeekday = [math getFirstWeekdayFromMonth:month andYear:year] - 1;
    int maxDay = [math getDaysFromMonth:month inYear:year];
    int day = 1;
    
    
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    [dformat setDateFormat:@"yyyy/MM/dd - HH:mm"];
    NSString *str = @"";
    
    
    for(int x = 0; x < 6; x++) {
        
        for(int y = 0; y < 7; y++) {
            
            DayObject *obj = [[DayObject alloc] init];
            
            
            if(y < indexWeekday && x == 0) {
                [obj setValidDay:[NSNumber numberWithBool:false]];
            }
            
            else if(day > maxDay) {
                [obj setValidDay:[NSNumber numberWithBool:false]];
                
            }
            
            else {
                [obj setValidDay:[NSNumber numberWithBool:true]];
            }
            
            
            if([[obj validDay] boolValue]) {
                str = [NSString stringWithFormat:@"%04d/%02d/%02d - 12:00", year, month, day];
                NSDate *date = [dformat dateFromString:str];
                [obj setDate:date];
                
                day++;
            }
            
            
            [obj setHasTraining:[NSNumber numberWithBool:false]];
            
            [[dayArray objectAtIndex:y] addObject:obj];
            
        }
        
    }
    
    return dayArray;
    
}

@end
