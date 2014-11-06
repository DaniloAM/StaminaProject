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

#pragma mark - Receiver

-(void)receiveRunningRoute: (FinishedRoute *)runningRoute {
    
    _route = runningRoute;
    
}

#pragma mark - ViewController methods

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated withGesture:false];
    
    if(_route) {
        [self drawTrajectoryDone];
    }

    [super showBarWithAnimation:true];
    
    
    [self.view setBackgroundColor:[UIColor staminaYellowColor]];
    
    [self setButtonImageNameLeft:@"icon_add_unable.png" andRight:@"icon_compartilha_unable.png"];
    
    [self setButtonActionLeft:@selector(enableRouteNameTextField) andRight:@selector(selectSharingOption)];
    
}



-(void)viewDidLoad{
    [super viewDidLoad];
    
    
}



-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    NSString *name = @"Name";
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    NSError *error = nil;
    
    TrajectoryFile *file = [NSEntityDescription insertNewObjectForEntityForName:@"TrajectoryFile" inManagedObjectContext:context];
    
    [file setTrajectoryName:name];
    [file setDateDone:[NSDate date]];
    [file setDuration:[NSNumber numberWithInt:([_route timeInSeconds] + [_route timeInMinutes] * 60)]];
    [file setDistance:[NSNumber numberWithDouble:[_route distanceInMeters]]];
    
    
    if(_saveRoute) {
    
        TrajectoryRoute *saveRoute = [NSEntityDescription insertNewObjectForEntityForName:@"TrajectoryRoute" inManagedObjectContext:context];
        
        [saveRoute setPicturesArray:[NSKeyedArchiver archivedDataWithRootObject:_route.arrayOfPictures]];
        [saveRoute setArrayOfLocations:[NSKeyedArchiver archivedDataWithRootObject:_route.arrayOfLocations]];
        
        [saveRoute setTrajectoryName:name];
        [saveRoute setTrajectoryDistance:[NSNumber numberWithDouble:[_route distanceInMeters]]];
        
        UserData *userData = [UserData alloc];
        [[userData routesArray] addObject:saveRoute];
    
    }
    
    [context save:&error];
    
}


#pragma mark - Load Trajectory methods

-(void)drawTrajectoryDone {
    
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


#pragma mark - Buttons actions


-(void)setButtonActionLeft: (void *)left andRight: (void *)right {
    
    if([[self leftButton] allTargets] != nil) {
    
    [[self leftButton] removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    
    [[self rightButton] removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];

    }
        
    [[self leftButton] addTarget:self action:left forControlEvents:UIControlEventTouchUpInside];
    
    [[self rightButton] addTarget:self action:right forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)setButtonImageNameLeft: (NSString *)left andRight: (NSString *)right {
    
    [[self leftButton] setBackgroundImage:[UIImage imageNamed:left] forState:UIControlStateNormal];
    [[self rightButton] setBackgroundImage:[UIImage imageNamed:right] forState:UIControlStateNormal];
    
}


-(void)enableRouteNameTextField {
    
    _saveRoute = true;
    
    [[self routeNameTextField] setHidden:false];
    
    [[self leftButton] setHidden:true];
    [[self rightButton] setHidden:true];
    
    
}


-(void)confirmRouteName {
    
    
    [[self routeNameTextField] setHidden:true];
    
    [[self leftButton] setHidden:true];
    [[self rightButton] setHidden:true];
    
}


-(void)selectSharingOption {
    
    [self setButtonImageNameLeft:@"icon_trajeto_unable.png" andRight:@"icon_camera_unable.png"];
    [self setButtonActionLeft:nil andRight:@selector(sharePicture)];
    
}


-(void)rightSlideAction {
    
    int state;
    
    if(state == 0) {
        [self.navigationController popViewControllerAnimated:true];
    }
    
    if(state == 1) {
        _saveRoute = false;
    }
    
    if(state == 1 || state == 2) {
        
    }
    
}


-(void)sharePicture {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"shareScreen"];
    
    [self.navigationController pushViewController:myVC animated:YES];
    
}


-(void)goHome {
    
    [self.navigationController popToRootViewControllerAnimated:true];
    
}


-(void)saveTrajectory {
    
    _saveRoute = true;
    [self goHome];
    
}



@end
