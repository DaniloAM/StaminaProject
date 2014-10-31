//
//  TrajectorySelectionVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 29/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "TrajectorySelectionVC.h"

#define tableViewRowHeight 45.0

@interface TrajectorySelectionVC ()

@end

@implementation TrajectorySelectionVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _expandedRow = -1;
    [self setUser:[UserData alloc]];
    
    [self setRouteTableView:[[UITableView alloc] init]];
    
    [[self routeTableView] setDelegate:self];
    [[self routeTableView] setDataSource:self];
    [[self routeTableView] setBackgroundColor:[UIColor staminaYellowColor]];
    [[self routeTableView] setSeparatorColor:[UIColor staminaBlackColor]];
    
    [[self routeTableView] setRowHeight:tableViewRowHeight];
    [[self routeTableView] reloadData];
    
    [self.view addSubview:[self routeTableView]];
    
}


-(void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    
    [[self routeTableView] setFrame:
     CGRectMake(
                
        // origin X
        0,
                
        //origin Y
        [self navigationIncreased].height / 2,
                
        //size width
        [[UIScreen mainScreen] bounds].size.width,
                
        //size height
        [[UIScreen mainScreen] bounds].size.height - [self tabBar].frame.size.height - [self navigationSize].height)];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _user.routesArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //cell.selectedBackgroundView.backgroundColor = [UIColor staminaBlackColor];
    
    //If the cell that is loading is the expanded one
    if(indexPath.row == _expandedRow) {
        
        [self insertRouteInfoInCell:cell];
        
    }
    
    //Else loads the title of the other routes
    else {
        
        cell.textLabel.text = [[[[self user] routesArray] objectAtIndex:indexPath.row] trajectoryName];
        cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:20.0];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
    
    }
    
    
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == _expandedRow) {
        
        return [[UIScreen mainScreen] bounds].size.height - [self tabBar].frame.size.height - [self navigationSize].height;
        
    }
    
    else return tableViewRowHeight;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(indexPath.row < [[[self user] routesArray] count]) {
    
        
        //Get the trajectoryRoute object for the selected row
        _expandedRoute = [[[self user] routesArray] objectAtIndex:indexPath.row];
        
        [[self routeTableView] scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
        
        
        //Set the value so the delegate knows what row needs to expand
        _expandedRow = (int) indexPath.row;
        
        
        //Get the last indexPath and the current in array
        NSMutableArray *array = [NSMutableArray array];
        
        if([self expandedIndexPath]) {
            [array addObject:[self expandedIndexPath]];
            
        }
        
        [array addObject:indexPath];
        
        
        //Reload only the previous and this indexPath
        [[self routeTableView] reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
        
        
        //The new expandedIndexPath
        _expandedIndexPath = indexPath;
        
        
        //Scroll to the selected row
        [[self routeTableView] scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
        
    }
    
}

-(void)insertRouteInfoInCell: (UITableViewCell *)cell {

    cell.backgroundColor = [UIColor staminaYellowColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, tableViewRowHeight)];
    
    title.text = [[[[self user] routesArray] objectAtIndex:_expandedRow] trajectoryName];
    
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor staminaBlackColor];
    title.textColor = [UIColor staminaYellowColor];
    [title setFont:[UIFont fontWithName:@"Avenir" size:20.0]];
    
    
    
    
    RoutePointsCartesian *cartesian = [[RoutePointsCartesian alloc] init];
    
    //Set the size of the frame
    UIImageView *imageView = [cartesian returnDrawedViewWithXArray:[NSKeyedUnarchiver unarchiveObjectWithData:[_expandedRoute arrayOfPointsInX]] yArray:[NSKeyedUnarchiver unarchiveObjectWithData:[_expandedRoute arrayOfPointsInY]] InSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width * 0.9, tableViewRowHeight * 2.5)];
    
    
    imageView.center = cell.center;
    
    [imageView setFrame:CGRectMake(imageView.frame.origin.x, tableViewRowHeight * 3, imageView.frame.size.width, imageView.frame.size.height)];
    
    
    
    [cell addSubview:imageView];
    [cell addSubview:title];
    
}

@end
