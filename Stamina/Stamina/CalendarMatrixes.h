//
//  CalendarMatrixes.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 12/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//
//---------------------------------------------------------------------//
//
//  This class prepare and return all the matrixes necessary to the calendar.
//
//  You need to pass in the init the calendar sizes and dimensions.
//
//
//
//  Label matrix - already with the correct position passed by the init.
//
//  Button matrix - already with the correct position passed by the init.
//
//  DayObject - starts with the correct date passed to it and no trainings.
//
//
//
//  * The other preparations are made by the CalendarPreparer class. *
//
//---------------------------------------------------------------------//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DayObject.h"
#import "CalendarMath.h"

@interface CalendarMatrixes : NSObject

//@property int startXPos;
//@property int startYPos;
//@property int XSize;
//@property int YSize;
//@property float fontSize;
//@property int spacement;
//@property UIColor *fontColor;

//-(id)initWithCalendarPositionsX: (int)xPos Y: (int)yPos Xsize: (int)xSize Ysize: (int)ySize  spacement: (int)spc fontSize: (float)fontSize fontColor: (UIColor *)color;
//
//-(NSMutableArray *)getLabelMatrixForCalendar;
//-(NSMutableArray *)getButtonMatrixForCalendar;
//-(NSMutableArray *)getDayObjectMatrixCalendarForMonth: (int)month andYear: (int)year;
+(NSArray *)getMatrixCalendarScrollInMonth: (int)month andYear : (int)year;

@end
