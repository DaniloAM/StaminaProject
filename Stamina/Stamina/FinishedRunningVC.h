//
//  FinishedRunningVC.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 30/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunningRoute.h"
#import "SocialSharingVC.h"

@interface FinishedRunningVC : UIViewController

@property RunningRoute* route;

@property (weak, nonatomic) IBOutlet UILabel *calLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *routeImageView;

-(void)receiveRunningRoute: (RunningRoute *)runningRoute;

@end
