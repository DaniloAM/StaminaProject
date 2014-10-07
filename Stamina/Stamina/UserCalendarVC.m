//
//  UserCalendarVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 12/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "UserCalendarVC.h"

@interface UserCalendarVC ()

@end

@implementation UserCalendarVC

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setPreparer:[[CalendarPreparer alloc] init]];
    
    NSDate *date = [NSDate date];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    _calendarMonth = (int) comp.month;
    _calendarYear = (int) comp.year;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self reloadCalendarInformation];
}


-(void)loadCalendarInteractionWithLabels: (NSMutableArray *)arrayLabels andButtons: (NSMutableArray *)arrayButtons {
 
    for(int x=0;x<7;x++) {
        for(int y=0;y<6;y++) {
            
            [self.view addSubview:[[arrayLabels objectAtIndex:x] objectAtIndex:y]];
            [self.view addSubview:[[arrayButtons objectAtIndex:x] objectAtIndex:y]];
        }
    }
}


-(void)reloadCalendarInformation {
    
    [[self yearLabel] setText:[NSString stringWithFormat:@"%d", _calendarYear]];
    
    [[self monthLabel] setText:[CalendarMath returnMonthName:_calendarMonth]];
    
    NSArray *arrayOfMatrixes = [[self preparer] getCalendarMatrixesForMonth:_calendarMonth andYear:_calendarYear];
    
    if([self labelMatrix] && [self buttonMatrix]) {
        
        for(int x=0;x<6;x++) {
            
            for(int y=0;y<7;y++) {
                
                [[[[self labelMatrix] objectAtIndex:y] objectAtIndex:x] removeFromSuperview];
                [[[[self buttonMatrix] objectAtIndex:y] objectAtIndex:x] removeFromSuperview];
            }
        }
        
    }
    
    [self setDayMatrix:[NSMutableArray arrayWithArray:[arrayOfMatrixes objectAtIndex:0]]];
    [self setLabelMatrix:[NSMutableArray arrayWithArray:[arrayOfMatrixes objectAtIndex:1]]];
    [self setButtonMatrix:[NSMutableArray arrayWithArray:[arrayOfMatrixes objectAtIndex:2]]];
    
    
    for(int x=0;x<6;x++) {
        
        for(int y=0;y<7;y++) {
            
            UILabel *label = [[[self labelMatrix] objectAtIndex:y] objectAtIndex:x];
            UIButton *button = [[[self buttonMatrix] objectAtIndex:y] objectAtIndex:x];
            
            if([[[[[self dayMatrix] objectAtIndex:y] objectAtIndex:x] hasTraining] boolValue]) {
                
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            [self.view addSubview:label];
            [self.view addSubview:button];
                
        }
            
    }
    
}

-(IBAction)nextMonth {
    
    _calendarMonth++;
    
    if(_calendarMonth > 12) {
        
        _calendarMonth = 1;
        _calendarYear++;
        
    }
    
    [self reloadCalendarInformation];
    
}

-(IBAction)previousMonth {
    
    _calendarMonth--;
    
    if(_calendarMonth < 1) {
        
        if(_calendarYear != 2000) {
            
            _calendarMonth = 12;
            _calendarYear--;
            
        }
        
        else {
            
            _calendarMonth = 1;
            
            return;
        }
        
    }
    
    [self reloadCalendarInformation];
    
}


-(void)buttonAction: (UIButton *)sender {
    
    int y = (int)sender.tag / 10;
    int x = (int)sender.tag - (y * 10);
    
    DayObject *day = [[[self dayMatrix] objectAtIndex:y] objectAtIndex:x];
    
    [[self trainingNameLabel] setText:day.trainingName];
    
}

-(void)showTrainingInfo {
    
    //UserData *data = [UserData alloc];
    //UserTraining *training = [data returnTrainingNamed:[[self trainingNameLabel] text]];
    
    
    //Perform change to View passing the parameter
    
}


//////////////////////////////////////
//////  TEST-ONLY METHODS BELLOW  ////
//////  TEST-ONLY METHODS BELLOW  ////
//////  TEST-ONLY METHODS BELLOW  ////
//////////////////////////////////////
//
//-(IBAction)sep {
//    
//    NSMutableArray *array = [NSMutableArray array];
//    
//    
//    
//    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
//    [dformat setDateFormat:@"yyyy/MM/dd - HH:mm"];
//    
//    
//    for(int day = 15; day < 30; day += 2) {
//        DayObject *obj = [[DayObject alloc] init];
//        
//        NSString *str = [NSString stringWithFormat:@"%04d/%02d/%02d - 12:00", 2014, 9, day];
//        NSDate *date = [dformat dateFromString:str];
//        [obj setDate:date];
//        //[obj setHasTraining:[NSNumber numberWithBool:true]];
//        
//        [array addObject:obj];
//    }
//
//    CalendarObject *calendar = [CalendarObject alloc];
//    
//    [calendar addDayObjects:array];
//}
//
//-(IBAction)nov {
//    
//    NSMutableArray *array = [NSMutableArray array];
//    
//    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
//    [dformat setDateFormat:@"yyyy/MM/dd - HH:mm"];
//    
//    
//    for(int day = 15; day < 30; day += 2) {
//        DayObject *obj = [[DayObject alloc] init];
//        
//        NSString *str = [NSString stringWithFormat:@"%04d/%02d/%02d - 12:00", 2014, 11, day];
//        NSDate *date = [dformat dateFromString:str];
//        [obj setDate:date];
//        
//        [array addObject:obj];
//    }
//    
//    CalendarObject *calendar = [CalendarObject alloc];
//    
//    [calendar addDayObjects:array];
//}
//
//-(IBAction)dec {
//    
//    NSMutableArray *array = [NSMutableArray array];
//    
//    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
//    [dformat setDateFormat:@"yyyy/MM/dd - HH:mm"];
//    
//    
//    for(int day = 15; day < 30; day += 2) {
//        DayObject *obj = [[DayObject alloc] init];
//        
//        NSString *str = [NSString stringWithFormat:@"%04d/%02d/%02d - 12:00", 2014, 12, day];
//        NSDate *date = [dformat dateFromString:str];
//        [obj setDate:date];
//        
//        [array addObject:obj];
//    }
//    
//    CalendarObject *calendar = [CalendarObject alloc];
//    
//    [calendar addDayObjects:array];
//}
//
//-(IBAction)dozmirekimze {
//    
//    NSMutableArray *array = [NSMutableArray array];
//    
//    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
//    [dformat setDateFormat:@"yyyy/MM/dd - HH:mm"];
//    
//    
//    for(int mon = 1; mon < 11; mon++) {
//        
//        for(int day = 1; day < 28; day += 3) {
//            
//            DayObject *obj = [[DayObject alloc] init];
//            
//            NSString *str = [NSString stringWithFormat:@"%04d/%02d/%02d - 12:00", 2015, mon, day];
//            NSDate *date = [dformat dateFromString:str];
//            [obj setDate:date];
//            
//            [array addObject:obj];
//        }
//    }
//    
//    CalendarObject *calendar = [CalendarObject alloc];
//    
//    [calendar addDayObjects:array];
//}




@end
