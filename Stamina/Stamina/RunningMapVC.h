//
//  RunningMapVC.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 26/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RunningRoute.h"
#import "FinishedRunningVC.h"

@interface RunningMapVC : UIViewController <MKMapViewDelegate , CLLocationManagerDelegate, UIAlertViewDelegate>

@property (weak , nonatomic) IBOutlet MKMapView *mapRunningView;
@property MKPolyline *routeLine;
@property MKPolylineView *routeLineView;
@property CLLocationManager *locationManager;
@property CLLocation *oldLocation;
@property CLLocation *firstLocation;

@property MapRoutePoints *pointsForRoute;

@property IBOutlet UILabel *timeLabel;
@property IBOutlet UILabel *speedLabel;
@property IBOutlet UILabel *distanceLabel;

@property float distanceInMeters;
@property NSMutableArray *overlayArray;
@property int seconds, minutes;
@property NSTimer *timer;


@end
