//
//  GraphicScroller.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 10/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "GraphicScroller.h"

#define graphHeight 280.0
#define graphWidth 270.0
#define borderIncrease 60.0

#define animationDuration 0.8
#define expandFactor 1.1


@implementation GraphicScroller



-(void)initGraphic {
    
    [self setMonthLabel:[[UILabel alloc] initWithFrame:CGRectMake(20, 100, 140, 100)]];
    [[self monthLabel] setNumberOfLines:2];
    [[self monthLabel] setFont:[UIFont fontWithName:@"Avenir" size:20.0]];
    [[self monthLabel] setText:@"TESTA"];
    
    [self setGraphLoadState:GSNormal];
    [self setLineColor:[UIColor blackColor]];
    [self setGraphicFrame:CGRectMake(0, 0, graphWidth, graphHeight)];
    
    [self setGraphicScrollView:[[UIScrollView alloc] init]];
    
    [[self graphicScrollView] setBackgroundColor:[UIColor clearColor]];
    [[self graphicScrollView] setDelegate:self];
    [[self graphicScrollView] setFrame:[self graphicFrame]];
    [[self graphicScrollView] setContentSize:CGSizeMake(graphWidth * viewSizeNumber, graphHeight)];
    [[self graphicScrollView] setContentOffset:CGPointMake(graphWidth * 2, 0)];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction)];

    [doubleTap setNumberOfTapsRequired:2];
    
    [[self graphicScrollView] addGestureRecognizer:doubleTap];
}



-(void)doubleTapAction {
    
    if([self graphLoadState] == GSExpanding || [self graphLoadState] == GSContracting) {
        return;
    }
    
    if([[self updater] isExpanded]) {
        [self setGraphLoadState:GSContracting];
    }
    
    else [self setGraphLoadState:GSExpanding];
    
    [self performAnimationByGraphState];
    
}


-(void)setGraphicLineColor: (UIColor *)color {
    
    [self setLineColor:color];
}


-(void)startNewGraphicScrollViewWithUpdater: (GraphUpdater *)updater expanded:(BOOL)expanded {
    
    [self initGraphic];
    [self setUpdater:updater];
    [[self updater] setIsExpanded:expanded];
    
    CGRect viewFrame = CGRectMake(0, 0, graphWidth * viewSizeNumber, graphHeight);
    
    [self setCurrentGraphicView:[[UIView alloc] initWithFrame:viewFrame]];
    [self setNextGraphicView:[[UIView alloc] initWithFrame:viewFrame]];
    [self setPreviousGraphicView:[[UIView alloc] initWithFrame:viewFrame]];
    
    [self prepareGraphicViews];
    [self reloadScrollViewGraphic];
    [self changeMonthText];
    
}



-(void)prepareGraphicViews {
    
    //Number of data per view frame
    NSInteger number = [[self updater] numberInView];
    
    
    //Images of the graphics and month labels
    UIImageView *previous = [self generateGraphImageWithNumbers:
                             [[self updater] previousNumberArray] numberShowingInView:number];
    
    
    UIImageView *current = [self generateGraphImageWithNumbers:
                            [[self updater] currentNumberArray] numberShowingInView:number];
    
    
    UIImageView *next = [self generateGraphImageWithNumbers:
                         [[self updater] nextNumberArray] numberShowingInView:number];
    
    
    //Add the images inside the views
    [[self currentGraphicView] addSubview:current];
    [[self nextGraphicView] addSubview:next];
    [[self previousGraphicView] addSubview:previous];
    
    //Add bottom labels inside the views
    [self addBottomLabels:[[self updater] currentBottomLabels] inView:[self currentGraphicView]];
    [self addBottomLabels:[[self updater] nextBottomLabels] inView:[self nextGraphicView]];
    [self addBottomLabels:[[self updater] previousBottomLabels] inView:[self previousGraphicView]];
    
}


-(void)addBottomLabels: (NSArray *)labelArray inView: (UIView *)view  {
    
    UIImage *image;
    
    double widthFactor = [self graphicFrame].size.width / _updater.numberInView;
    
    CGSize contextSize = CGSizeMake(_graphicFrame.size.width * viewSizeNumber, borderIncrease);
    
    UIGraphicsBeginImageContextWithOptions(contextSize, NO, 0.0);
    
    CGRect frame = CGRectMake(-widthFactor / 2, 0, widthFactor, borderIncrease / 1.5);
    
    for(int x = 0; x < [labelArray count]; x++) {
        
        UILabel *label = [labelArray objectAtIndex:x];
        [label drawTextInRect:frame];
        frame.origin.x += widthFactor;
        
        if(frame.origin.x > (graphWidth * 5) + widthFactor) {
            break;
        }

    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *bottomImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, graphHeight - borderIncrease, graphWidth * 5, borderIncrease)];
    
    bottomImage.image = image;
    
    [view addSubview:bottomImage];
    
}


-(void)addSubviews: (NSArray *)subviews inView: (UIView *)view {
    
    for(int x = 0; x < [subviews count]; x++) {
        [view addSubview:[subviews objectAtIndex:x]];
    }
}



-(void)reloadScrollViewGraphic {
    
    [[self currentGraphicView] removeFromSuperview];
    
    if([self graphLoadState] == GSForwarding) {
        
        [[self updater] advanceGraphicDate];
        
        [self setPreviousGraphicView:[self currentGraphicView]];
        [self setCurrentGraphicView:[self nextGraphicView]];
        
        [self setGraphLoadState:GSLoadingNext];
    }
    
    else if([self graphLoadState] == GSBackwarding) {
        
        [[self updater] regressGraphicDate];
        
        [self setNextGraphicView:[self currentGraphicView]];
        [self setCurrentGraphicView:[self previousGraphicView]];
        
        [self setGraphLoadState:GSLoadingPrevious];
    }
    
    
    [[self graphicScrollView] addSubview:[self currentGraphicView]];
    
    [[self graphicScrollView] setContentOffset:CGPointMake(graphWidth * 2, 0)];
    
    [self performSelectorInBackground:@selector(loadNewGraphicByState) withObject:nil];
    
}



-(void)removeAllSubviewsFromView: (UIView *)view {
    
    NSInteger subviewCount = [[view subviews] count];
    
    for(int x = 0; x < subviewCount; x++) {
        
        [[[view subviews] objectAtIndex:x] removeFromSuperview];
        
    }
    
}

-(void)checkMonthLabel {
    
    double point = [[self graphicScrollView] contentOffset].x + (graphWidth / 2);
    
    
    if(point < _rightLabelInterval || point > _leftLabelInterval) {
        return;
    }
    
    else [self changeMonthText];
    
}


-(void)changeMonthText {
    
    //get the center point offset of graphic
    double point = [[self graphicScrollView] contentOffset].x + (graphWidth / 2);
    
    //get the graphic center date
    NSDate *graphDate =  [NSDate dateWithTimeInterval:0 sinceDate:[[self updater] graphCenterDate]];
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    
    [comp setDay:[[self updater] numberInView] / 2];
    
    //change the date to the date in the view center
    graphDate = [[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:graphDate options:0];
    
    //prepare to get month name string
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    
    //get date components
    comp = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:graphDate];
    
    
    //set label text with month and year
    [[self monthLabel] setText:[NSString stringWithFormat: @"%@\n%d", [formatter stringFromDate:graphDate],(int) comp.year]];
    
    //get day count of month
    NSRange dayRange = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                                          inUnit:NSMonthCalendarUnit
                                                         forDate:graphDate];
    
    //calculate the limits of this month
    double widthFactor = [self graphicFrame].size.width / [[self updater] numberInView];
    
    NSInteger right = dayRange.length - (comp.day - 1);
    NSInteger left = comp.day - 1;
    
    _rightLabelInterval = point + (right * widthFactor);
    _leftLabelInterval = point - (left * widthFactor);
    
  
    
}


-(void)loadNewGraphicByState {
    
    if([self graphLoadState] == GSLoadingNext) {
        
        CGRect viewFrame = CGRectMake(0, 0, graphWidth * viewSizeNumber, graphHeight);
        [self setNextGraphicView:[[UIView alloc] initWithFrame:viewFrame]];
        
        [self removeAllSubviewsFromView:[self nextGraphicView]];
        
        UIImageView *next = [self generateGraphImageWithNumbers:
                             [[self updater] nextNumberArray] numberShowingInView:[[self updater] numberInView]];
        
        [[self nextGraphicView] addSubview:next];
        
        [self addBottomLabels:[[self updater] nextBottomLabels] inView:[self nextGraphicView]];
        
        [self changeMonthText];
        
        [self setGraphLoadState:GSNormal];
        
    }
    
    else if([self graphLoadState] == GSLoadingPrevious) {
        
        CGRect viewFrame = CGRectMake(0, 0, graphWidth * viewSizeNumber, graphHeight);
        [self setPreviousGraphicView:[[UIView alloc] initWithFrame:viewFrame]];
        
        UIImageView *previous = [self generateGraphImageWithNumbers:
                                 [[self updater] previousNumberArray] numberShowingInView:[[self updater] numberInView]];
        
        [[self previousGraphicView] addSubview:previous];
        
        [self addBottomLabels:[[self updater] previousBottomLabels] inView:[self previousGraphicView]];
        
        [self changeMonthText];
        
        [self setGraphLoadState:GSNormal];
        
    }
    
    [self changeMonthText];
    
}



-(UIImageView *)generateGraphImageWithNumbers: (NSArray *)array numberShowingInView: (NSInteger)numberView {
    
    
    if([array count] < numberView * viewSizeNumber) {
        return nil;
    }
    
    NSInteger max = 0;
    
    
    
    for(NSNumber *number in array) {
        
        if(number.integerValue > max) {
            max = number.integerValue;
        }
        
    }
    
    /*  Increase the frame by the size of the line,
     so the line doesnt cross the frame limit.    */
    
    
    _graphicFrame.size.height += borderIncrease;
    
    
    //Factors for the graphic
    double heightFactor = (graphHeight - borderIncrease) / max;
    double widthFactor = [self graphicFrame].size.width / numberView;
    double radius = [self graphicFrame].size.width / 20.0;
    double lineSize = (graphHeight - borderIncrease) / 40.0;
    
    //Case of math error
    if(max == 0) {
        heightFactor = 0;
    }

    
    UIImage *image = [[UIImage alloc] init];
    
    CGSize contextSize = CGSizeMake(_graphicFrame.size.width * viewSizeNumber, _graphicFrame.size.height);
    
    //UIGraphicsBeginImageContext(contextSize);
    UIGraphicsBeginImageContextWithOptions(contextSize, NO, 0.0);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [self lineColor].CGColor);
    
    for(NSInteger index = 0; index < [array count]; index++) {
        
        
        //Set point (A)
        CGPoint pointA = CGPointMake(index * widthFactor,(graphHeight - borderIncrease) - ([[array objectAtIndex:index] doubleValue] * heightFactor) + (graphHeight / 20));
        
        //Draw the point (A)
        CGContextFillEllipseInRect (UIGraphicsGetCurrentContext(), CGRectMake(pointA.x - (radius / 2), pointA.y - (radius / 2), radius, radius));
        
        
        if(index + 1 >= [array count]) {
            break;
        }
        
        //Set point (B)
        CGPoint pointB = CGPointMake((index + 1) * widthFactor,(graphHeight - borderIncrease) - ([[array objectAtIndex:index+1] doubleValue] * heightFactor) + (graphHeight / 20));
        
        
        //Draw the line from point (A)
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), pointA.x, pointA.y);
        //to point (B)
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), pointB.x, pointB.y);
        
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineSize);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        
    }

    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    _graphicFrame.size.height -= borderIncrease;
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(_graphicFrame.origin.x, _graphicFrame.origin.y, _graphicFrame.size.width * viewSizeNumber, _graphicFrame.size.height)];
    
    [view setImage:image];
    
    return view;
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self checkMonthLabel];
    
    if(scrollView.contentOffset.x <= 0 && _graphLoadState == GSNormal) {
        
        _graphLoadState = GSBackwarding;
        [self reloadScrollViewGraphic];
    }
    
    
    else if(scrollView.contentOffset.x >= graphWidth * 4 && _graphLoadState == GSNormal){
        
        _graphLoadState = GSForwarding;
        [self reloadScrollViewGraphic];
    }
    
}


-(void)performAnimationByGraphState {
    
    UIView *view = [self copyOfView:[self currentGraphicView]];
    
    
    if([self graphLoadState] == GSContracting) {
        
        [self setIsAnimating:true];
        
        [[self graphicScrollView] addSubview:view];
        
        [self performSelectorInBackground:@selector(prepareNewGraphicForm) withObject:nil];
        
        [UIView animateWithDuration:animationDuration animations:^{
            
            for(UIView *sub in [view subviews]) {
                
                CGRect frame = sub.frame;
                
                double leftSize = [self graphicScrollView].contentOffset.x;
                double rightSize = (graphWidth * 4) - leftSize;
                
                if(leftSize > rightSize) {
                    frame.size.width = frame.size.width - (rightSize / 2);
                    frame.origin.x = frame.origin.x + (rightSize / 3);
                }
                
                else {
                    frame.origin.x = frame.origin.x + (leftSize / 4);
                    frame.size.width = frame.size.width - (leftSize / 2);
                }
                
                [sub setFrame:frame];
                [sub setAlpha:0.0];
                
            }
        
        } completion:^(BOOL finished) {
            
            if(finished) {
                [view removeFromSuperview];
                [self setIsAnimating:false];
            }
        }];
        
    }
    
    else if([self graphLoadState] == GSExpanding) {
        
        [self setIsAnimating:true];
        
        [[self graphicScrollView] addSubview:view];
        
        [self performSelectorInBackground:@selector(prepareNewGraphicForm) withObject:nil];
    
        
        [UIView animateWithDuration:animationDuration animations:^{
                
            for(UIView *sub in [view subviews]) {
                
                CGRect frame = sub.frame;
                
                double originChange = ((frame.size.width * expandFactor) - frame.size.width) / 2;
                frame.size.width = frame.size.width * expandFactor;
                frame.origin.x = frame.origin.x - originChange;
                
                [sub setFrame:frame];
                [sub setAlpha:0.0];
                
            }
            
        } completion:^(BOOL finished) {
            
            if(finished) {
                [view removeFromSuperview];
                [self setIsAnimating:false];
            }
        }];
    }
}

-(void)prepareNewGraphicForm {
    
    [[self currentGraphicView] removeFromSuperview];
    
    if([self graphLoadState] == GSContracting) {
        
        [[self updater] contractGraphic];
        
    }
    
    else if([self graphLoadState] == GSExpanding) {
        
        [[self updater] expandGraphic];
        
    }
    
    CGRect viewFrame = CGRectMake(0, 0, graphWidth * viewSizeNumber, graphHeight);
    
    [self setCurrentGraphicView:[[UIView alloc] initWithFrame:viewFrame]];
    [self setNextGraphicView:[[UIView alloc] initWithFrame:viewFrame]];
    [self setPreviousGraphicView:[[UIView alloc] initWithFrame:viewFrame]];

    [self prepareGraphicViews];
    
    [[self graphicScrollView] setAlpha:0.0];
    
    [self reloadScrollViewGraphic];
    
    while([self isAnimating]) {

    }
    
    [self setGraphLoadState:GSNormal];
    
    [UIView animateWithDuration:animationDuration/2 animations:^{
        
        [[self graphicScrollView] setAlpha:1.0];
        
    }];
    
}


-(UIView*)copyOfView: (UIView *)viewToCopy {
    
    NSData* viewCopyData = [NSKeyedArchiver archivedDataWithRootObject:viewToCopy];
    return [NSKeyedUnarchiver unarchiveObjectWithData:viewCopyData];

}


@end
