//
//  TrajectorySelectionVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 29/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "TrajectorySelectionVC.h"

#define tableViewRowHeight 45.0
#define fontLabelSize 22.0

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
    //cell.selectedBackgroundView.backgroundColor = [UIView alloc staminaBlackColor];
    
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
    
    if(indexPath == _expandedIndexPath) {
        return;
    }
    
    
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
    
    //Title of Route
    CGRect titleFrame = CGRectMake(0, 0, cell.frame.size.width, tableViewRowHeight);
    
    UILabel *title = [UILabel staminaLabelWithFrame:titleFrame fontSize:20.0 color:[UIColor staminaYellowColor]];
    
    title.text = [[[[self user] routesArray] objectAtIndex:_expandedRow] trajectoryName];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor staminaBlackColor];
    
    
    
    //Double tap gesture to close the cell
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeExpandedRow)];
    
    [doubleTap setNumberOfTapsRequired:2];
    
    
    
    //Image of the route
    RoutePointsCartesian *cartesian = [[RoutePointsCartesian alloc] init];
    
    UIImageView *imageView = [cartesian returnDrawedViewWithXArray:[NSKeyedUnarchiver unarchiveObjectWithData:[_expandedRoute arrayOfPointsInX]] yArray:[NSKeyedUnarchiver unarchiveObjectWithData:[_expandedRoute arrayOfPointsInY]] InSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width * 0.9, tableViewRowHeight * 2.5)];
    
    imageView.center = cell.center;
    
    [imageView setFrame:CGRectMake(imageView.frame.origin.x, tableViewRowHeight * 3, imageView.frame.size.width, imageView.frame.size.height)];
    
    
    
    NSArray *array = [self getHistoryOfThisRoute];
    
    
    
    CGRect infoFrame = CGRectMake(cell.frame.size.width / 5, [[UIScreen mainScreen] bounds].size.height - [self tabBar].frame.size.height - [self navigationSize].height - (tableViewRowHeight * 5), cell.frame.size.width / 3, tableViewRowHeight);
    
    CGRect imageFrame = CGRectMake(0, 0, infoFrame.size.height * 0.75, infoFrame.size.height  * 0.75);
    
    
    for(int x = 0; x < 4; x++) {
        
        
        if(x == 1 || x == 3) {
            infoFrame.origin.x = cell.frame.size.width / 1.5;
        }
        
        else {
            infoFrame.origin.x = cell.frame.size.width / 5;
            infoFrame.origin.y += tableViewRowHeight * 1.5;
        }
        

        imageFrame.origin.y = infoFrame.origin.y;
        
        
        UILabel *infoLabel = [UILabel staminaLabelWithFrame:infoFrame fontSize:22.0 color:[UIColor staminaBlackColor]];
        
        int value = [[array objectAtIndex:x] intValue];
        
        if(x != 2) {
            infoLabel.text = [NSString stringWithFormat:@"%03d", value];
        }
        
        else {
            infoLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", value/60/60, value/60, value%60];
        }
        
        [cell addSubview:infoLabel];
        
        NSString *imageName;
        
        switch (x) {
            case 0:
                imageName = @"icon_calorias.png";
                break;
            case 1:
                imageName = @"icon_km.png";
                break;
            case 2:
                imageName = @"icon_cronometro.png";
                break;
            case 3:
                imageName = @"icon_pontos.png";
                break;
            default:
                break;
        }
        
        
        UIImageView *imageView = [[UIImageView alloc]
                                  initWithImage:[UIImage imageNamed:imageName]];
        
        imageFrame.origin.x = infoLabel.frame.origin.x - (imageFrame.size.width * 1.3);
        
        imageView.frame = imageFrame;
        
        [cell addSubview:imageView];
        
    }
    
    
    //Add items to cell
    [cell addGestureRecognizer:doubleTap];
    [cell addSubview:imageView];
    [cell addSubview:title];
    
}



-(NSArray *)getHistoryOfThisRoute {
    
    int timeInSeconds = 0, calories = 0, points = 0, timesDone;
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TrajectoryFile"];
    NSError *error;
    
    NSArray *routesHistory = [context executeFetchRequest:request error:&error];
    
    for(TrajectoryFile *file in routesHistory) {
        
        if([file.trajectoryName isEqualToString:[[self expandedRoute] trajectoryName]]) {
        
            timesDone++;
            
            //INSERT HERE CALORIES AND POINTS
            //*******************************
            timeInSeconds += file.duration.intValue;
        
        }
        
    }
    
    timeInSeconds /= timesDone;
    calories /= timesDone;
    points /= timesDone;
    
    
    
    //Return an array with calories, distance, time and points
    return @[[NSNumber numberWithInt:calories],[[self expandedRoute] trajectoryDistance],[NSNumber numberWithInt:timeInSeconds],[NSNumber numberWithInt:points]];
    
}



-(void)closeExpandedRow {
    
    _expandedRow = -1;
    _expandedRoute = nil;
    
    [[self routeTableView] reloadRowsAtIndexPaths:@[_expandedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    _expandedIndexPath = nil;
    
}


@end
