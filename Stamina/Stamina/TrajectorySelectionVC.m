//
//  TrajectorySelectionVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 29/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "TrajectorySelectionVC.h"

#define tableViewRowHeight 40.0
#define rowsVisibleInScreen 8

@interface TrajectorySelectionVC ()

@end

@implementation TrajectorySelectionVC

- (void)viewDidLoad {
    
    _expandedRow = -1;
    
    [self setUser:[UserData alloc]];
    
    [[self routeTableView] setDelegate:self];
    [[self routeTableView] setDataSource:self];
    
    
    [[self routeTableView] setRowHeight:tableViewRowHeight];
    [[self routeTableView] reloadData];
    
    [super viewDidLoad];
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.routeTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[self routeTableView] setDelegate:self];
    [[self routeTableView] setDataSource:self];
    
    [self.routeTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _user.routesArray.count + rowsVisibleInScreen;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    

    
    if(indexPath.row < [[[self user] routesArray] count]) {
    
        cell.textLabel.text = [[[[self user] routesArray] objectAtIndex:indexPath.row] trajectoryName];
        cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:20.0];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
    
    }
    
    
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == _expandedRow) {
        
        return [[UIScreen mainScreen] bounds].size.height - self.navigationController.navigationBar.frame.size.height;
        
    }
    
    else return tableViewRowHeight;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(indexPath.row < [[[self user] routesArray] count]) {
    
        
        //Get the trajectoryRoute object for the selected row
        TrajectoryRoute *route = [[[self user] routesArray] objectAtIndex:indexPath.row];
        
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

@end