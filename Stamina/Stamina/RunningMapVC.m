//
//  RunningMapVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 26/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "RunningMapVC.h"

@interface RunningMapVC ()

@end

@implementation RunningMapVC



#pragma mark - Receiver

-(void)receiveTrajectorySelected: (TrajectoryRoute *)route {
    
    if(route) {
        
        _userRoute = true;
        
        NSArray *locations = [NSKeyedUnarchiver unarchiveObjectWithData:[route arrayOfLocations]];
        
        CLLocationCoordinate2D coordinates[[locations count]];
        
        [[self mapRunningView] addOverlay:_routeLine];
        
        for(int x = 0; x < [locations count]; x++) {
            
            coordinates[x] = [[locations objectAtIndex:x] coordinate];
            
        }
        
        _routeLine = [MKPolyline polylineWithCoordinates:coordinates count:[locations count]];
        
    }
    
}



#pragma mark - ViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setPictureViewController:[[SocialSharingVC alloc] init]];
    [[self pictureViewController] setRoutePicture:true];
    
    [self.view setBackgroundColor:[UIColor staminaYellowColor]];
    [[UIApplication sharedApplication] setIdleTimerDisabled:true];
    
    [self setOverlayArray:[NSMutableArray array]];
    [self setLocationsArray:[NSMutableArray array]];
    [self setPicturesArray:[NSMutableArray array]];
    
    [[self mapRunningView] setDelegate:self];
    [self setLocationManager:[[CLLocationManager alloc] init]];
    [[self locationManager] setDelegate:self];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [[self locationManager] requestAlwaysAuthorization];
    }
    
    [[self mapRunningView] setShowsUserLocation:true];
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    
    
    if([self userRoute] && [self routeLine]) {
        
        _userRouteIsDraw = true;
        [[self mapRunningView] addOverlay:_routeLine];
    }
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[self locationManager] startUpdatingLocation];
    [[self mapRunningView] setShowsUserLocation:true];
    
    [super hideBarWithAnimation:true];
    
    if([self isWaitingForPicture]) {
        [self setIsWaitingForPicture:false];
        
        if([[self pictureViewController] userPicture]) {
            [self savePictureOfRoutePlace:[[self pictureViewController] userPicture]];
        }
    }
    
    [self zoomToUserRegion];
}



-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:false];
    
}



#pragma mark - Map Delegates


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    if(!_oldLocation) {
        _firstLocation = [locations lastObject];
        _oldLocation = [locations lastObject];
        return;
    }
    
    if([_firstLocation isEqual:_oldLocation]) {
        _oldLocation = [locations lastObject];
        return;
    }
    
    CLLocation *newLocation;
    
    for(int i = 0; i < [locations count]; i++) {
        
        newLocation = [locations objectAtIndex:i];
        
        CLLocationDistance distance = [_oldLocation distanceFromLocation:newLocation];
        
        if([self isRunning])
            _distanceInMeters += distance;
        
        [self drawRouteLayerWithPointOne:_oldLocation andTwo:newLocation];
        
        [[self locationsArray] addObject:newLocation];
        
        _oldLocation = newLocation;
    }
    
    if([newLocation speed] >= 0)
        [[self speedLabel] setText:[NSString stringWithFormat:@"%.01f Km/h", ([newLocation speed] * 3.6)]];
    
    else {
        [[self speedLabel] setText:@""];
    }
    
    [self updateTextInDistanceLabel];
    
}


- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKOverlayView* overlayView = nil;
    self.routeLineView = [[MKPolylineView alloc] initWithPolyline:[self routeLine]];
    
    if(_userRouteIsDraw) {
        
        [[self routeLineView] setFillColor:[UIColor colorWithRed:100/255.0f green:250/255.0f blue:100/255.0f alpha:1.0]];
        
        [[self routeLineView] setStrokeColor:[UIColor colorWithRed:100/255.0f green:250/255.0f blue:100/255.0f alpha:1.0]];
        
        _userRouteIsDraw = false;
    }
    
    else {
        
        [[self routeLineView] setFillColor:[UIColor colorWithRed:167/255.0f green:210/255.0f blue:244/255.0f alpha:1.0]];
        
        [[self routeLineView] setStrokeColor:[UIColor colorWithRed:106/255.0f green:151/255.0f blue:232/255.0f alpha:1.0]];
    }
    
    [[self routeLineView] setLineWidth:15.0];
    [[self routeLineView] setLineCap:kCGLineCapRound];
    overlayView = [self routeLineView];
    
    [[self overlayArray] addObject:overlayView];
    return overlayView;
}


#pragma mark - Map drawing


-(void)drawRouteLayerWithPointOne: (CLLocation *)locationOne andTwo: (CLLocation *)locationTwo  {
    
    if (!locationOne || !locationTwo)
    {
        return;
    }
    
    
    CLLocationCoordinate2D coordinates[2];
    
    coordinates[0] = locationOne.coordinate;
    coordinates[1] = locationTwo.coordinate;
    
    
    _routeLine = [MKPolyline polylineWithCoordinates:coordinates count:2];
    
    [[self mapRunningView] addOverlay:_routeLine];
    
}



#pragma mark - Reloads Timer


-(void)startReloadingUserPosition {
    
    if(_seconds % 8 == 1) {
        [self zoomToUserRegion];
    }
    [self updateTextInTimeLabel];
    _seconds++;
    
    if(_seconds >= 60) {
        _minutes++;
        _seconds = 0;
    }
    
}


-(void)zoomToUserRegion {
    
    MKCoordinateRegion region;
    region.center.latitude = self.mapRunningView.userLocation.coordinate.latitude;
    region.center.longitude = self.mapRunningView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = 0.002;
    region.span.longitudeDelta = 0.002;
    
    [self.mapRunningView setRegion:region animated:true];
    
}



-(void)updateTextInTimeLabel {
    
    [[self timeLabel] setText:[NSString stringWithFormat:@"%d:%02d:%02d", (_minutes / 60), (_minutes % 60), _seconds]];
    
}


-(void)updateTextInDistanceLabel {
    
    if(_distanceInMeters >= 1000.0f) {
        [[self distanceLabel] setText:[NSString stringWithFormat:@"%.01f Km", _distanceInMeters / 1000]];
    }
    
    else {
        [[self distanceLabel] setText:[NSString stringWithFormat:@"%d m", (int) _distanceInMeters]];
    }
    
}


#pragma mark - Buttons methods


-(IBAction)takePlacePicture {
    
    if(![self isRunning]) {
        return;
    }
    
    [self setIsWaitingForPicture:YES];
    [self callView:[self pictureViewController]];
  

}


-(void)savePictureOfRoutePlace: (UIImage *)pic {
    
    UIImageView *view = [[UIImageView alloc] init];
    view.tag = [[self locationsArray] count] - 1;
    
    [[self picturesArray] addObject:view];
    
    [self setPictureViewController:[[SocialSharingVC alloc] init]];
    [[self pictureViewController] setRoutePicture:true];
}



-(IBAction)finishButton: (UIButton *)sender {
    
    if(![self isRunning]) {
        
        [sender setTitle:@"Terminar" forState:UIControlStateNormal];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startReloadingUserPosition) userInfo:nil repeats:true];
        
        [self setIsRunning:true];
    }
    
    
    else {
        
        //[sender setTitle:@"Iniciar" forState:UIControlStateNormal];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Parar" message:@"Deseja parar a corrida?" delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
        
        [alertView show];
        
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        return;
    }
    if (buttonIndex == 1) {
        [self finishRunning];
    }
}


-(void)finishRunning {
    
    FinishedRoute *route = [[FinishedRoute alloc] init];
    
    [route setArrayOfLocations:[self locationsArray]];
    
    
    //Create a new RoutePointsCartesian
    
    RoutePointsCartesian *cartesian =[[RoutePointsCartesian alloc] init];
    
    //Add the location points to cartesian
    for(int x = 0; x < [[self locationsArray] count]; x++) {
        
        MKMapPoint point = MKMapPointForCoordinate([[[self locationsArray] objectAtIndex:x] coordinate]);
        
        [cartesian addPointToRouteInX:point.x andY:point.y];
    }
    
    
    //Prepare the cartesian system for the map points
    [cartesian prepareForCartesian];
    
    [route setTimeInSeconds:_seconds];
    [route setTimeInMinutes:_minutes];
    [route setDistanceInMeters:_distanceInMeters];
    [route setRoutePoints:cartesian];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FinishedRunningVC *myVC = (FinishedRunningVC *)[storyboard instantiateViewControllerWithIdentifier:@"finishedRunning"];

    //Receive the route to draw it
    [myVC receiveRunningRoute:route];
    
    [self.navigationController pushViewController:myVC animated:YES];
    
}


@end
