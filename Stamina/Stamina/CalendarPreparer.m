//
//  CalendarPreparer.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 15/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CalendarPreparer.h"

@implementation CalendarPreparer

//-(id)init {
//    self = [super init];
//    
//    if(self) {
//        
//        [self setMatrixes:[[CalendarMatrixes alloc] initWithCalendarPositionsX:25 Y:182 Xsize:30 Ysize:30 spacement:0 fontSize:12.0f fontColor:[UIColor blackColor]]];
//        
//        _trainingColor = [UIColor redColor];
//        
//    }
//    
//    return self;
//}
//
//
////-(NSArray *)getCalendarMatrixesForMonths:(int)month andYear:(int)year {
////    
////    CalendarMatrixes *calendarMatrixes = [[CalendarMatrixes alloc] init];
////    
////    
////    
////    
////}
//
//
//-(NSArray *)getCalendarMatrixesForMonth: (int)month andYear: (int)year {
//    
//    CalendarMatrixes *calendarMatrixes = [[CalendarMatrixes alloc] init];
//    
//    
//    NSMutableArray *dayMatrix = [self insertDayInformationInDayMatrix:[calendarMatrixes getDayObjectMatrixCalendarForMonth:month andYear:year] forMonth:month andYear:year];
//
//    
//    return [NSArray arrayWithObjects:dayMatrix , [self getCalendarLabelsWithDayArray:dayMatrix],[self getCalendarButtonsWithDayArray:dayMatrix], nil];
//
//}
//
//
//-(NSMutableArray *)insertDayInformationInDayMatrix: (NSMutableArray *)array forMonth: (int)month andYear: (int)year {
//    
//    CalendarObject *calendar = [CalendarObject alloc];
//    
//    NSMutableArray *trainings = [NSMutableArray arrayWithArray:[calendar getTrainingsInMonth:month andYear:year]];
//    
//    NSDate *dateTraining;
//    NSDateComponents *compTraining;
//    
//    if([trainings count] > 0) {
//        
//        dateTraining = [[trainings firstObject] date];
//        compTraining = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dateTraining];
//        
//        
//        for(int x = 0; x < 6; x++) {
//            
//            for(int y = 0; y < 7; y++) {
//                
//                if([[[[array objectAtIndex:y] objectAtIndex:x] validDay] boolValue] && [[[array objectAtIndex:y] objectAtIndex:x] date]) {
//                    
//                    NSDate *date = [[[array objectAtIndex:y] objectAtIndex:x] date];
//                    NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
//                    
//                    dateTraining = dateTraining;
//                    
//                    if(compTraining.day == comp.day) {
//                        
//                        DayObject *new = [[array objectAtIndex:y] objectAtIndex:x];
//                        TrainingDayObject *day = [trainings firstObject];
//                        
//                        [new setDate:date];
//                        [new setWasDone:day.wasDone];
//                        [new setDateDone:day.dateDone];
//                        [new setDoneState:day.doneState];
//                        [new setHasTraining:[NSNumber numberWithBool:true]];
//                        [new setTrainingName:day.trainingName];
//                        [new setWeekdayNumber:day.weekdayNumber];
//                        
//                        [trainings removeObjectAtIndex:0];
//                        
//                        if([trainings count] < 1) {
//                            break;
//                        }
//                        
//                        dateTraining = [[trainings firstObject] date];
//                        compTraining = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dateTraining];
//                        
//                    }
//                }
//            }
//            
//            if([trainings count] < 1) {
//                break;
//            }
//        }
//    }
//    
//    
//    
//    
//    return array;
//    
//}
//
//-(NSMutableArray *)getCalendarButtonsWithDayArray: (NSMutableArray *)dayArray {
//    
//    NSMutableArray *buttons = [[self matrixes] getButtonMatrixForCalendar];
//    
//    for(int x = 0; x < 6; x++) {
//        
//        for(int y = 0; y < 7; y++) {
//            
//            if([[[[dayArray objectAtIndex:y] objectAtIndex:x] hasTraining] boolValue]) {
//                
//                [[[buttons objectAtIndex:y] objectAtIndex:x] setTag:((y*10) + x)];
//            
//            }
//        
//        }
//        
//    }
//    
//    return buttons;
//
//}
//
//
//-(NSMutableArray *)getCalendarLabelsWithDayArray: (NSMutableArray *)dayArray {
//    
//    NSMutableArray *labels = [[self matrixes] getLabelMatrixForCalendar];
//    
//    int day = 1;
//    
//    for(int x = 0; x < 6; x++) {
//        
//        for(int y = 0; y < 7; y++) {
//            
//            if([[[[dayArray objectAtIndex:y] objectAtIndex:x] validDay] boolValue]) {
//                
//                [[[labels objectAtIndex:y] objectAtIndex:x] setText:[NSString stringWithFormat:@"%d", day]];
//                
//                if([[[[dayArray objectAtIndex:y] objectAtIndex:x] hasTraining] boolValue])
//                    [[[labels objectAtIndex:y] objectAtIndex:x] setTextColor:_trainingColor];
//                
//                day++;
//        
//            }
//        }
//        
//    }
//    
//    return labels;
//    
//}


+(NSArray *)getCalendarScrollViewWithLabelsButtons {
    
    UIScrollView *calendarView = [[UIScrollView alloc] init];
    
    NSMutableArray *labelMatrix = [NSMutableArray array];
    NSMutableArray *buttonMatrix = [NSMutableArray array];
    
    int height = 205;
    int maxLines = 16;
    
    CGSize calendarScrollSize = CGSizeMake(270, maxLines * 35);
    CGSize calendarDayLabelSize = CGSizeMake(30, 30);
    
    [calendarView setFrame:CGRectMake(0, 0, calendarScrollSize.width, height)];
    [calendarView setContentSize:calendarScrollSize];
    
    int spacementDayLabelInX = 10;
    int spacementDayLabelInY = 5;
    
    int xPos = 0, yPos = 0, arrayIndexY = 0;
    
    for(int y = 0; y < 16; y++) {
        
        [labelMatrix addObject:[NSMutableArray array]];
        [buttonMatrix addObject:[NSMutableArray array]];
        
        for(int x = 0; x < 7; x++) {
            
            CGRect frame = CGRectMake(xPos, yPos, calendarDayLabelSize.width , calendarDayLabelSize.height);
            
            UILabel *label = [[UILabel alloc] initWithFrame:frame];
            UIButton *button = [[UIButton alloc]initWithFrame:frame];
            
            [label setFont:[UIFont fontWithName:@"Avenir" size:18.0]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor blackColor]];
            
            [[labelMatrix objectAtIndex:y] addObject:label];
            [[buttonMatrix objectAtIndex:y] addObject:button];
            
            [calendarView addSubview:label];
            [calendarView addSubview:button];
            
            xPos = xPos + calendarDayLabelSize.width + spacementDayLabelInX;
            
        }
        
        yPos = yPos + calendarDayLabelSize.height + spacementDayLabelInY;
        arrayIndexY++;
        xPos = 0;
    }
    
    
    //return 3 arrays, the first with the view, the second with the labels and the last with the buttons
    return [NSArray arrayWithObjects:[NSArray arrayWithObject:calendarView], labelMatrix, buttonMatrix, nil];
    
}



@end
