//
//  FinishedRunningVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 30/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "FinishedRunningVC.h"

@interface FinishedRunningVC ()

@end

@implementation FinishedRunningVC


-(void)receiveRunningRoute: (RunningRoute *)runningRoute {
    
    _route = runningRoute;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(_route) {
        
        [self drawTrajectoryDone];
        
    }
    
}


-(void)drawTrajectoryDone {
    
    [self setTrajectoryInfo];
    
    UIImageView *routeView = _route.routePoints.returnDrawedViewWithCurrentRoute;
    
    if(routeView == nil) {
        return;
    }
    
    double fator;
    
    if(routeView.frame.size.width > routeView.frame.size.height) {
        fator = ( 180 / routeView.frame.size.width );
        
    } else {
        fator = ( 180 / routeView.frame.size.height );
        
    }
    
    
    [routeView setFrame:CGRectMake(0, 0, routeView.frame.size.width * fator , routeView.frame.size.height * fator)];
    
    routeView.center = _routeImageView.center;
    
    [_routeImageView removeFromSuperview];
    [self.view addSubview:routeView];
    
    
    [self setTrajectoryInfo];

}


-(void)setTrajectoryInfo {
    
    if(_route.distanceInMeters >= 1000.0f) {
        [[self distanceLabel] setText:[NSString stringWithFormat:@"%.01f Km", _route.distanceInMeters / 1000]];
    }
    
    else {
        [[self distanceLabel] setText:[NSString stringWithFormat:@"%d m", (int) _route.distanceInMeters]];
    }
    
    [[self timeLabel] setText:[NSString stringWithFormat:@"%d:%02d:%02d", (_route.timeInMinutes / 60), (_route.timeInMinutes  % 60), _route.timeInSeconds]];
    
}


-(IBAction)sharePicture {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"shareScreen"];
    
    [self.navigationController pushViewController:myVC animated:YES];
    
}


-(IBAction)goHome {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"homeScreen"];
    
    [self.navigationController pushViewController:myVC animated:YES];
    
}


-(void)saveTrajectory {
    
}








@end
