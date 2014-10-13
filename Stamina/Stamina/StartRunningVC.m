//
//  StartRunningVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 10/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "StartRunningVC.h"

@interface StartRunningVC ()

@end

@implementation StartRunningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUserData:[UserData alloc]];
    [self setSelectedRouteView:[[UIImageView alloc] init]];
    
    [[self routesTableView] setDelegate:self];
    [[self routesTableView] setDataSource:self];
    
    [[self routesTableView] setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:[self selectedRouteView]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _userData.routesArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[[[self userData] routesArray] objectAtIndex:indexPath.row] trajectoryName];
    cell.textLabel.font = [UIFont systemFontOfSize:19.0];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self drawTrajectoryWithImageViewAtIndex:indexPath.row];
    
}

-(void)drawTrajectoryWithImageViewAtIndex: (NSInteger)index {
    
    TrajectoryRoute *route = [[[self userData] routesArray] objectAtIndex:index];
    RoutePointsCartesian *cartesian = [[RoutePointsCartesian alloc] init];
    
    //Set the size of the frame
    UIImageView *imageView = [cartesian returnDrawedViewWithXArray:[NSKeyedUnarchiver unarchiveObjectWithData:[route arrayOfPointsInX]] yArray:[NSKeyedUnarchiver unarchiveObjectWithData:[route arrayOfPointsInY]] InSize:CGSizeMake(200, 150)];
    
    if(imageView == nil) {
        return;
    }
    
    _selectedRouteView.frame = imageView.frame;
    _selectedRouteView.image = imageView.image;
    _selectedRouteView.center = _routeView.center;
    
}



@end
