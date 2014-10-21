//
//  CalendarPreparer.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 15/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CalendarPreparer.h"

@implementation CalendarPreparer


+(NSArray *)getCalendarScrollViewWithLabelsButtons {
    
    
    UIScrollView *calendarView = [[UIScrollView alloc] init];
    
    NSMutableArray *labelMatrix = [NSMutableArray array];
    NSMutableArray *buttonMatrix = [NSMutableArray array];
    
    int height = 205;
    int maxLines = 16;
    int spacementDayLabelInX = 10;
    int spacementDayLabelInY = 5;
    
    CGSize calendarScrollSize = CGSizeMake(270, maxLines * 35);
    CGSize calendarDayLabelSize = CGSizeMake(30, 30);
    
    [calendarView setFrame:CGRectMake(0, 0, calendarScrollSize.width, height)];
    [calendarView setContentSize:calendarScrollSize];
    
    
    
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
    
    
    //return 3 arrays, the first with the view, the second with the labels matrix and the last with the buttons matrix
    return [NSArray arrayWithObjects:[NSArray arrayWithObject:calendarView], labelMatrix, buttonMatrix, nil];
    
}


+(NSArray *)getMatrixCalendarScrollInMonth: (int)month andYear : (int)year {
    
    month--;
    
    if(month < 1) {
        month = 12;
        year--;
    }
    
    //Checa os valores do mes anterior para saber seus ultimos dias
    int prevMonth, prevYear, day = 1, monthsInCalendar = 0, line = 0, position = 0, lastLine = 0;
    
    if(month == 1) {
        prevMonth = 12;
        prevYear = year - 1;
    }
    
    else {
        prevMonth = month - 1;
        prevYear = year;
    }
    
    //Descobre o ultimo dia do mes passado, em que dia da semana comeca o mes
    //atual e o ultimo dia do mes.
    int previousMonthDay = [CalendarMath getDaysFromMonth:prevMonth inYear:prevYear];
    
    int startWeekday = [CalendarMath getFirstWeekdayFromMonth:month andYear:year] - 1;
    
    int lastDay = [CalendarMath getDaysFromMonth:month inYear:year];
    
    previousMonthDay -= startWeekday;
    previousMonthDay++;
    
    NSMutableArray *array = [NSMutableArray array];
    
    //Prepara o formato de data para salvar cada dia
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    [dformat setDateFormat:@"yyyy/MM/dd - HH:mm"];
    NSString *str = @"";
    
    
    //Inicia a criacao dos DayObjects para cada dia dos meses
    //line é equivalente ao Y e guarda quantas linhas tem o calendario
    for(line = 0; ; line++) {
        
        [array addObject:[NSMutableArray array]];
        
        for(int x = 0; x < 7; x++) {
            
            if(day > lastDay) {
                monthsInCalendar++;
                
                if(monthsInCalendar == 1) {
                    position = line;
                }
                
                day = 1;
                month++;
                
                if(month > 12) {
                    month = 1;
                    year++;
                }
                
                lastDay = [CalendarMath getDaysFromMonth:month inYear:year];
                
            }
            
            DayObject *object = [[DayObject alloc] init];
            
            if(line == 0 && x < startWeekday) {
                
                str = [NSString stringWithFormat:@"%04d/%02d/%02d - 12:00", prevYear, prevMonth, previousMonthDay];
                
                previousMonthDay++;
                
            }
            
            else {
                
                str = [NSString stringWithFormat:@"%04d/%02d/%02d - 12:00", year, month, day];
                
                day++;
                
            }
            
            NSDate *date = [dformat dateFromString:str];
            
            if (date)
                [object setDate:date];
            
            [[array objectAtIndex:line] addObject:object];
            
        }
        
        if(monthsInCalendar >= 3 && lastLine == 1) {
            break;
        }
        
        else if(monthsInCalendar >= 3) {
            lastLine = 1;
        }
        
    }
    
    //The line position of the first day of the month
    [array addObject:[NSNumber numberWithInt:position]];
    
    return array;
    
}



@end
