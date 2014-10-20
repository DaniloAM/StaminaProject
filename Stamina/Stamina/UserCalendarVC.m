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


// X , Y
//
//Object at index X addObject:
//
// if
//
//        X   (0)   (1)   (2)   (3)   (4)   (5)   (6)
//             V     V     V     V     V     V     V
//             V     V     V     V     V     V     V
////////////////////////////////////////////////////////
//    Y    //     |     |     |     |     |     |     //
// (0) > > // 0,0 | 1,0 | 2,0 | 3,0 | 4,0 | 5,0 | 6,0 //
//         //-----|-----|-----|-----|-----|-----|-----//
// (1) > > // 0,1 | 1,1 | 2,1 | 3,1 | 4,1 | 5,1 | 6,1 //
//         //-----|-----|-----|-----|-----|-----|-----//
// (2) > > // 0,2 | 1,2 | 2,2 | 3,2 | 4,2 | 5,2 | 6,2 //
//         //-----|-----|-----|-----|-----|-----|-----//
// (3) > > // 0,3 | 1,3 | 2,3 | 3,3 | 4,3 | 5,3 | 6,3 //
//         //-----|-----|-----|-----|-----|-----|-----//
// (4) > > // 0,4 | 1,4 | 2,4 | 3,4 | 4,4 | 5,4 | 6,4 //
//         //-----|-----|-----|-----|-----|-----|-----//
// (5) > > // 0,5 | 1,5 | 2,5 | 3,5 | 4,5 | 5,5 | 6,5 //
//         //     |     |     |     |     |     |     //
////////////////////////////////////////////////////////

// 205 HEIGHT X3 = 615 px
//
// 270 WIDTH  X3 = 810 px

-(void)prepareCalendarScrollViewWithCurrentMonth {
    
    _locationNextMonth = -1;
    
    NSArray *calendarMatrix = [CalendarMatrixes getMatrixCalendarScrollInMonth:_calendarMonth andYear:_calendarYear];
    
    CGSize calendarScrollSize = CGSizeMake(270, ([calendarMatrix count] - 1) * 35);
    [[self calendarScrollView] setContentSize:calendarScrollSize];
    
    //Set to start on the center of the content
    [[self calendarScrollView] setContentOffset:CGPointMake(0, [[calendarMatrix lastObject] intValue] * 35)];
    
    
    for(int y = 0; ([calendarMatrix count] - 1) > y; y++) {
        
        for(int x = 0; x < 7; x++) {
            
            UILabel *label = [[[self labelMatrix] objectAtIndex:y] objectAtIndex:x];
            UIButton *button = [[[self buttonMatrix] objectAtIndex:y] objectAtIndex:x];
            NSDate *date = [[[calendarMatrix objectAtIndex:y] objectAtIndex:x] date];
            
            if(date) {
                NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
                [label setText:[NSString stringWithFormat:@"%d", (int) comp.day]];
                
                if(comp.month != _calendarMonth) {
                    [label setAlpha:0.3];
                    
                    if(_locationNextMonth == 0) {
                        _locationNextMonth = y;
                    }
    
                }
                
                else {
                    _locationNextMonth = 0;
                    [label setAlpha:1.0];
                }
            }
            
        }
        
    }
    
}

-(void)loadCalendarScrollView {
    
    NSArray *array = [CalendarPreparer getCalendarScrollViewWithLabelsButtons];
    
    [self setCalendarScrollView:[[array objectAtIndex:0] firstObject]];
    [[self calendarScrollView] setCenter:self.view.center];
    [self setLabelMatrix:[array objectAtIndex:1]];
    [self setButtonMatrix:[array objectAtIndex:2]];
    
    [self.view addSubview:[self calendarScrollView]];
    [[self calendarScrollView] setUserInteractionEnabled:false];
    
    UISwipeGestureRecognizer *gestureUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextMonth)];
    [gestureUp setDirection:UISwipeGestureRecognizerDirectionUp];
    
    UISwipeGestureRecognizer *gestureDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previousMonth)];
    [gestureDown setDirection:UISwipeGestureRecognizerDirectionDown];
    
    [self.view addGestureRecognizer:gestureUp];
    [self.view addGestureRecognizer:gestureDown];
    
    
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setPreparer:[[CalendarPreparer alloc] init]];
    [self setCalendarScrollView:[[UIScrollView alloc]init]];
    
    NSDate *date = [NSDate date];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    _calendarMonth = (int) comp.month;
    _calendarYear = (int) comp.year;
    _locationNextMonth = -1;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self loadCalendarScrollView];
    [self prepareCalendarScrollViewWithCurrentMonth];
    [[self yearLabel] setText:[NSString stringWithFormat:@"%d", _calendarYear]];
    [[self monthLabel] setText:[CalendarMath returnMonthName:_calendarMonth]];
    
}





//-(void)loadCalendarGraphicsAndActions {
//    
//    for(int y = 0; y < 6; y++) {
//        for(int x = 0; x < 7; x++) {
//            
//            CGRect frame = CGRectMake(0, 0, 0, 0);
//            UILabel *label = [[UILabel alloc] initWithFrame:frame];
//            UIButton *button = [[UIButton alloc]initWithFrame:frame];
//            
//            [label setFont:[UIFont fontWithName:@"Avenir" size:18.0]];
//            
//            [[[self labelMatrix] objectAtIndex:y] addObject:label];
//            [[[self buttonMatrix] objectAtIndex:y] addObject:button];
//            
//            [self.view addSubview:label];
//            [self.view addSubview:button];
//        }
//    }
//}
//
//
//-(void)loadCalendarInteractionWithLabels: (NSMutableArray *)arrayLabels andButtons: (NSMutableArray *)arrayButtons {
// 
//    for(int x=0;x<7;x++) {
//        for(int y=0;y<6;y++) {
//            
//            [self.view addSubview:[[arrayLabels objectAtIndex:x] objectAtIndex:y]];
//            [self.view addSubview:[[arrayButtons objectAtIndex:x] objectAtIndex:y]];
//        }
//    }
//}
//
//
//-(void)reloadCalendarInformation {
//    
//    [[self yearLabel] setText:[NSString stringWithFormat:@"%d", _calendarYear]];
//    
//    [[self monthLabel] setText:[CalendarMath returnMonthName:_calendarMonth]];
//    
//    NSArray *arrayOfMatrixes = [[self preparer] getCalendarMatrixesForMonth:_calendarMonth andYear:_calendarYear];
//    
//    if([self labelMatrix] && [self buttonMatrix]) {
//        
//        for(int x=0;x<6;x++) {
//            
//            for(int y=0;y<7;y++) {
//                
//                [[[[self labelMatrix] objectAtIndex:y] objectAtIndex:x] removeFromSuperview];
//                [[[[self buttonMatrix] objectAtIndex:y] objectAtIndex:x] removeFromSuperview];
//            }
//        }
//        
//    }
//    
//    [self setDayMatrix:[NSMutableArray arrayWithArray:[arrayOfMatrixes objectAtIndex:0]]];
//    [self setLabelMatrix:[NSMutableArray arrayWithArray:[arrayOfMatrixes objectAtIndex:1]]];
//    [self setButtonMatrix:[NSMutableArray arrayWithArray:[arrayOfMatrixes objectAtIndex:2]]];
//    
//    
//    for(int x=0;x<6;x++) {
//        
//        for(int y=0;y<7;y++) {
//            
//            UILabel *label = [[[self labelMatrix] objectAtIndex:y] objectAtIndex:x];
//            UIButton *button = [[[self buttonMatrix] objectAtIndex:y] objectAtIndex:x];
//            
//            if([[[[[self dayMatrix] objectAtIndex:y] objectAtIndex:x] hasTraining] boolValue]) {
//                
//                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//                
//            }
//            
//            [self.view addSubview:label];
//            [self.view addSubview:button];
//                
//        }
//            
//    }
//    
//}

-(void)nextMonth {
    
    _calendarMonth++;
    
    if(_calendarMonth > 12) {
        
        _calendarMonth = 1;
        _calendarYear++;
        
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [[self calendarScrollView] setContentOffset:CGPointMake(0, _locationNextMonth * 35)];
    }];
    
    [self calendarWillChangeMonth];
    
}

-(void)previousMonth {
    
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
    
    [UIView animateWithDuration:0.5 animations:^{
        [[self calendarScrollView] setContentOffset:CGPointMake(0, 0)];
    }];
    
    [self calendarWillChangeMonth];
}


-(void)calendarWillChangeMonth {
    
    [self performSelector:@selector(prepareCalendarScrollViewWithCurrentMonth) withObject:nil afterDelay:0.5];
    [[self yearLabel] setText:[NSString stringWithFormat:@"%d", _calendarYear]];
    [[self monthLabel] setText:[CalendarMath returnMonthName:_calendarMonth]];
    
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
