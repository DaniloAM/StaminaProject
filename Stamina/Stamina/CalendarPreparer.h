//
//  CalendarPreparer.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 15/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//
//---------------------------------------------------------------------//
//
//  This class prepare the matrixes received by the CalendarMatrixes class.
//
//  This class return an array with three matrixes ready to work in the calendar.
//
//  The label text is set to the day based on the date, the button get an action if there
//  is traning and the DayObject get the trainings from the CalendarObject class.
//
//
//  The order returned is: DayObjects[0], Labels[1] and Buttons[2].
//
//  ** You need to call the init and pass the size parameters to it. **
//
//---------------------------------------------------------------------//
//

#import <Foundation/Foundation.h>
#import "CalendarMatrixes.h"
#import "CalendarObject.h"
#import "CalendarMath.h"

@interface CalendarPreparer : NSObject

@property CalendarMatrixes *matrixes;
@property UIColor *trainingColor;

-(NSArray *)getCalendarMatrixesForMonth: (int)month andYear: (int)year;

@end
