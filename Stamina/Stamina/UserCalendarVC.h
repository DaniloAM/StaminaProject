//
//  UserCalendarVC.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 12/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarPreparer.h"
#import "UserData.h"

@interface UserCalendarVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *trainingNameLabel;

@property CalendarPreparer *preparer;

@property NSMutableArray *dayMatrix;
@property NSMutableArray *labelMatrix;
@property NSMutableArray *buttonMatrix;

@property int calendarMonth;
@property int calendarYear;

@end
