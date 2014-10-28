//
//  CalendarInformationVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 24/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CalendarInformationVC.h"

@interface CalendarInformationVC ()

@end

@implementation CalendarInformationVC


-(void)receiveExercises: (NSArray *)exercises andDate: (NSDate *)date {
    
    _date = date;
    _exercisesList = exercises;
    
}




@end
