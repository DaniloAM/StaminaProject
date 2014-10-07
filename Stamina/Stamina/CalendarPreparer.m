//
//  CalendarPreparer.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 15/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CalendarPreparer.h"

@implementation CalendarPreparer

-(id)init {
    self = [super init];
    
    if(self) {
        
        [self setMatrixes:[[CalendarMatrixes alloc] initWithCalendarPositionsX:18 Y:149 Xsize:38 Ysize:38 spacement:3 fontSize:12.0f fontColor:[UIColor blackColor]]];
        
        _trainingColor = [UIColor redColor];
        
    }
    
    return self;
}

-(NSArray *)getCalendarMatrixesForMonth: (int)month andYear: (int)year {
    
    CalendarMatrixes *calendarMatrixes = [[CalendarMatrixes alloc] init];
    
    
    NSMutableArray *dayMatrix = [self insertDayInformationInDayMatrix:[calendarMatrixes getDayObjectMatrixCalendarForMonth:month andYear:year] forMonth:month andYear:year];

    
    return [NSArray arrayWithObjects:dayMatrix , [self getCalendarLabelsWithDayArray:dayMatrix],[self getCalendarButtonsWithDayArray:dayMatrix], nil];

}


-(NSMutableArray *)insertDayInformationInDayMatrix: (NSMutableArray *)array forMonth: (int)month andYear: (int)year {
    
    CalendarObject *calendar = [CalendarObject alloc];
    
    NSMutableArray *trainings = [NSMutableArray arrayWithArray:[calendar getTrainingsInMonth:month andYear:year]];
    
    NSDate *dateTraining;
    NSDateComponents *compTraining;
    
    if([trainings count] > 0) {
        
        dateTraining = [[trainings firstObject] date];
        compTraining = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dateTraining];
        
        
        for(int x = 0; x < 6; x++) {
            
            for(int y = 0; y < 7; y++) {
                
                if([[[[array objectAtIndex:y] objectAtIndex:x] validDay] boolValue] && [[[array objectAtIndex:y] objectAtIndex:x] date]) {
                    
                    NSDate *date = [[[array objectAtIndex:y] objectAtIndex:x] date];
                    NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
                    
                    dateTraining = dateTraining;
                    
                    if(compTraining.day == comp.day) {
                        
                        DayObject *new = [[array objectAtIndex:y] objectAtIndex:x];
                        TrainingDayObject *day = [trainings firstObject];
                        
                        [new setDate:date];
                        [new setWasDone:day.wasDone];
                        [new setDateDone:day.dateDone];
                        [new setDoneState:day.doneState];
                        [new setHasTraining:[NSNumber numberWithBool:true]];
                        [new setTrainingName:day.trainingName];
                        [new setWeekdayNumber:day.weekdayNumber];
                        
                        [trainings removeObjectAtIndex:0];
                        
                        if([trainings count] < 1) {
                            break;
                        }
                        
                        dateTraining = [[trainings firstObject] date];
                        compTraining = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dateTraining];
                        
                    }
                }
            }
            
            if([trainings count] < 1) {
                break;
            }
        }
    }
    
    
    
    
    return array;
    
}

-(NSMutableArray *)getCalendarButtonsWithDayArray: (NSMutableArray *)dayArray {
    
    NSMutableArray *buttons = [[self matrixes] getButtonMatrixForCalendar];
    
    for(int x = 0; x < 6; x++) {
        
        for(int y = 0; y < 7; y++) {
            
            if([[[[dayArray objectAtIndex:y] objectAtIndex:x] hasTraining] boolValue]) {
                
                [[[buttons objectAtIndex:y] objectAtIndex:x] setTag:((y*10) + x)];
            
            }
        
        }
        
    }
    
    return buttons;

}


-(NSMutableArray *)getCalendarLabelsWithDayArray: (NSMutableArray *)dayArray {
    
    NSMutableArray *labels = [[self matrixes] getLabelMatrixForCalendar];
    
    int day = 1;
    
    for(int x = 0; x < 6; x++) {
        
        for(int y = 0; y < 7; y++) {
            
            if([[[[dayArray objectAtIndex:y] objectAtIndex:x] validDay] boolValue]) {
                
                [[[labels objectAtIndex:y] objectAtIndex:x] setText:[NSString stringWithFormat:@"%d", day]];
                
                if([[[[dayArray objectAtIndex:y] objectAtIndex:x] hasTraining] boolValue])
                    [[[labels objectAtIndex:y] objectAtIndex:x] setTextColor:_trainingColor];
                
                day++;
        
            }
        }
        
    }
    
    return labels;
    
}


@end
