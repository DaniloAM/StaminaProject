//
//  CalendarMatrixes.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 12/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CalendarMatrixes.h"

@implementation CalendarMatrixes


//-(id)initWithCalendarPositionsX: (int)xPos Y: (int)yPos Xsize: (int)xSize Ysize: (int)ySize  spacement: (int)spc fontSize: (float)fontSize fontColor: (UIColor *)color {
//    self = [super init];
//    
//    if(self) {
//        
//        _startXPos = xPos;
//        _startYPos = yPos;
//        _XSize = xSize;
//        _YSize = ySize;
//        _fontSize = fontSize;
//        _spacement = spc;
//        _fontColor = color;
//        
//    }
//    
//    return self;
//}
//
//
//-(NSMutableArray *)getLabelMatrixForCalendar {
//    
//    NSMutableArray *labelArray = [NSMutableArray array];
//    
//    for(int x = 0; x < 7; x++) {
//        [labelArray addObject:[NSMutableArray array]];
//    }
//    
//    int xPos = _startXPos, yPos = _startYPos;
//    
//    for(int x=0;x<6;x++) {
//        
//        for(int y=0;y<7;y++) {
//            
//            UILabel *label = [[UILabel alloc] init];
//            
//            [label setFrame:CGRectMake(xPos, yPos, _XSize, _YSize)];
//            [label setTextAlignment:NSTextAlignmentCenter];
//            [label setText:@""];
//            [label setTextColor:_fontColor];
//            
//            [[labelArray objectAtIndex:y] addObject:label];
//            
//            xPos += _XSize + _spacement;
//        }
//        
//        xPos = _startXPos;
//        yPos += _YSize + _spacement;
//    }
//    
//    return labelArray;
//    
//}
//
//
//-(NSMutableArray *)getButtonMatrixForCalendar {
//    
//    NSMutableArray *buttonArray = [NSMutableArray array];
//    
//    for(int x = 0; x < 7; x++) {
//        [buttonArray addObject:[NSMutableArray array]];
//    }
//    
//    int xPos = _startXPos, yPos = _startYPos;
//    
//    for(int x=0;x<6;x++) {
//        
//        for(int y=0;y<7;y++) {
//            
//            UIButton *button = [[UIButton alloc] init];
//            
//            [button setFrame:CGRectMake(xPos, yPos, _XSize, _YSize)];
//            
//            [[buttonArray objectAtIndex:y] addObject:button];
//            
//            xPos += _XSize + _spacement;
//        }
//        
//        xPos = _startXPos;
//        yPos += _YSize + _spacement;
//    }
//    
//    return buttonArray;
//    
//}
//
//
//-(NSMutableArray *)getDayObjectMatrixCalendarForMonth: (int)month andYear: (int)year {
//    
//    NSMutableArray *dayArray = [NSMutableArray array];
//    
//    for(int x = 0; x < 7; x++) {
//        [dayArray addObject:[NSMutableArray array]];
//    }
//    
//    int indexWeekday = [CalendarMath getFirstWeekdayFromMonth:month andYear:year] - 1;
//    int previousMonthLastDay = [CalendarMath getDaysFromMonth:month inYear:year];
//    int maxDay = [CalendarMath getDaysFromMonth:month inYear:year];
//    int day = 1;
//    
//    
//    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
//    [dformat setDateFormat:@"yyyy/MM/dd - HH:mm"];
//    NSString *str = @"";
//    
//    
//    for(int x = 0; x < 6; x++) {
//        
//        for(int y = 0; y < 7; y++) {
//            
//            DayObject *obj = [[DayObject alloc] init];
//            
//            
//            if(y < indexWeekday && x == 0) {
//                [obj setValidDay:[NSNumber numberWithBool:false]];
//            }
//            
//            else if(day > maxDay) {
//                [obj setValidDay:[NSNumber numberWithBool:false]];
//                
//            }
//            
//            else {
//                [obj setValidDay:[NSNumber numberWithBool:true]];
//            }
//            
//            
//            if(day > maxDay) {
//                day = 1;
//            }
//            
//            str = [NSString stringWithFormat:@"%04d/%02d/%02d - 12:00", year, month, day];
//            NSDate *date = [dformat dateFromString:str];
//            [obj setDate:date];
//                
//            day++;
//            
//            
//            [obj setHasTraining:[NSNumber numberWithBool:false]];
//            
//            [[dayArray objectAtIndex:y] addObject:obj];
//            
//        }
//        
//    }
//    
//    for(int x = indexWeekday - 1; x >= 0; x++) {
//        
//    }
//    
//    return dayArray;
//    
//}


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
