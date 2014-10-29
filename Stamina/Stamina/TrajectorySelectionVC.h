//
//  TrajectorySelectionVC.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 29/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HideBBVC.h"
#import "UserData.h"

@interface TrajectorySelectionVC : HideBBVC <UITableViewDataSource , UITableViewDelegate>

@property UserData *user;
@property (weak, nonatomic) IBOutlet UITableView *routeTableView;

@property int expandedRow;
@property NSIndexPath *expandedIndexPath;

@end
