//
//  CalendarObject.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 11/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CalendarObject.h"

@implementation CalendarObject



+(CalendarObject *)sharedStore{
    static CalendarObject *sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
    
}

+(id) allocWithZone: (struct _NSZone *) zone{
    
    return [self sharedStore];
    
}


-(void)addDayObjects: (NSMutableArray *)array {
    
    if(!monthlyTrainingsArray) {
        [self allocArrays];
    }
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [app managedObjectContext];
    
    NSError *error = nil;
    
    
    for(int x = 0; x < [array count]; x++) {
        
        DayObject *day = [array objectAtIndex:x];
        
        if(![self dayObjectExistWithDate:day.date]) {
            
            TrainingDayObject *new = [NSEntityDescription insertNewObjectForEntityForName:@"TrainingDayObject" inManagedObjectContext:context];
            
            [new setDate:day.date];
            [new setWasDone:day.wasDone];
            [new setValidDay:day.validDay];
            [new setDateDone:day.dateDone];
            [new setDoneState:day.doneState];
            [new setHasTraining:day.hasTraining];
            [new setTrainingName:day.trainingName];
            [new setWeekdayNumber:day.weekdayNumber];
            
            [context save:&error];
            [self insertInArray:day];
            
        }
        
    }
  
    [self arrageAllArrays];
    
}

-(void)arrageAllArrays {
    
    for(int x = 0; x < 12; x++) {
        [self arrangeArray:[monthlyTrainingsArray objectAtIndex:x]];
    }

}


-(NSMutableArray *)arrangeArray: (NSMutableArray *)array {
    [array sortUsingComparator:^NSComparisonResult(DayObject *obj1, DayObject *obj2) {
        
        NSDate *date1 = [obj1 date];
        NSDateComponents *comp1 = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date1];
        
        NSDate *date2 = [obj2 date];
        NSDateComponents *comp2 = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date2];
        
        
        
        if (comp1.year < comp2.year) {
            return NSOrderedAscending;
        }
        
        else if (comp1.year > comp2.year) {
            return NSOrderedDescending;
        }
        
        else {
            
            if (comp1.day < comp2.day) {
                return NSOrderedAscending;
            }
            
            else if (comp1.day > comp2.day) {
                return NSOrderedDescending;
            }
            
            else return NSOrderedSame;
            
        }
    }];
    
    return array;
    
}


-(void)insertInArray: (DayObject *)day {
    
    NSDate *date = [day date];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    [[monthlyTrainingsArray objectAtIndex:comp.month - 1] addObject:day];
    
}

-(void)allocArrays {
    
    monthlyTrainingsArray = [NSMutableArray array];
    
    for(int x = 0; x < 12; x++) {
        NSMutableArray *month = [NSMutableArray array];
        [monthlyTrainingsArray addObject:month];
    }
    
}

-(void)removeDayObjects : (NSMutableArray *)array {
    
}



-(NSMutableArray *)getTrainingsInMonth: (int)month andYear: (int)year {
    
    NSMutableArray *trainings = [NSMutableArray array];
    
    NSMutableArray *monthArray = [monthlyTrainingsArray objectAtIndex:month - 1];
    
    int index = [self binarySearchForYear:year inArray:monthArray];
    
    if(index < 0) {
        //Nao ha treinos neste mes e ano
        return nil;
    }
    
    int leftIndex = index, rightIndex = index + 1;
    
    while(1) {
        
        if(leftIndex < 0) {
            break;
        }
        
        NSDate *date = [[monthArray objectAtIndex:leftIndex] date];
        NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
        
        if(comp.year != year) {
            break;
        }
        
        [trainings addObject:[monthArray objectAtIndex:leftIndex]];
        leftIndex--;
        
    }
    
    while(1) {
        
        if(rightIndex > [monthArray count] - 1) {
            break;
        }
        
        NSDate *date = [[monthArray objectAtIndex:rightIndex] date];
        NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
        
        if(comp.year != year) {
            break;
        }
        
        
        [trainings addObject:[monthArray objectAtIndex:rightIndex]];
        rightIndex++;
        
    }
    
    trainings = [self arrangeArray:trainings];
    
    return trainings;
    
}



-(int)binarySearchForYear: (int)year inArray: (NSMutableArray *)array {
    
    if(!array || [array count] < 1) {
        return -1;
    }
    
    int i = 0, fin = (int) [array count] - 1, str = 0;
    
    while (1) {
        
        i = (fin + str) / 2;
        
        NSDate *date = [[array objectAtIndex:i] date];
        NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
        
        
        if(comp.year == year) {
            return i;
        }
        
        
        else if (comp.year > year) {
            fin = i - 1;
        }
        
        else {
            
            str = i + 1;
        }
        
        if(fin < str) {
            return -1;
        }
    }
}


-(BOOL)dayObjectExistWithDate: (NSDate *)dayDate {

    if(!monthlyTrainingsArray) {
        return false;
    }
    
    NSDateComponents *comp1 = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dayDate];
    
    int day = (int) comp1.day;
    int year = (int) comp1.year;
    
    NSArray *array = [monthlyTrainingsArray objectAtIndex:comp1.month - 1];
    
    if([array count] < 1) {
        return false;
    }
    
    int i = 0, fin = (int) [array count] - 1, str = 0;
    
    while (1) {
        
        i = (fin + str) / 2;
        
        NSDate *date = [[array objectAtIndex:i] date];
        NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
        
        
        if(comp.year == year) {
            
            
            if(comp.day == day) {
                return true;
            }
            
            
            else if (comp.day > day) {
                fin = i - 1;
            }
            
            else {
                
                str = i + 1;
            }
            
        }
        
        else if(comp.year > year ) {
            fin = i - 1;
            
        }
        
        
        else {
            str = i + 1;
        }
        
        if(fin < str) {
            return false;
        }

    }
}


-(NSArray *)getMonthArrays {
    
    return monthlyTrainingsArray;
    
}




@end
