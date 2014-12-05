//
//  GraphicScroller.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 10/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import"GraphUpdater.h"

@interface GraphicScroller : NSObject <UIScrollViewDelegate>

typedef enum GraphicState {
    GSNormal,
    GSBackwarding,
    GSForwarding,
    GSLoadingNext,
    GSLoadingPrevious,
    GSExpanding,
    GSContracting
}GraphicState;

@property GraphicState state;

@property UILabel *monthLabel;

@property UIView *nextGraphicView;
@property UIView *previousGraphicView;
@property UIView *currentGraphicView;

@property NSMutableArray *graphicData;
@property NSMutableArray *infoData;

@property double leftLabelInterval;
@property double rightLabelInterval;

@property UIImageView *graphicImage;
@property UIImageView *nextGraphicImage;
@property UIScrollView *graphicScrollView;

@property NSInteger maxValue;
@property NSInteger minValue;
@property NSInteger graphLoadState;

@property CGRect graphicFrame;
@property UIColor *lineColor;
@property GraphUpdater *updater;

@property BOOL isAnimating;

-(void)startNewGraphicScrollViewWithUpdater: (GraphUpdater *)updater expanded:(BOOL)expanded;
-(void)setGraphicLineColor: (UIColor *)color;

@end
