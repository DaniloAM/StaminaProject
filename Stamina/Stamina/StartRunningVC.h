//
//  StartRunningVC.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 10/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "UserData.h"
#import "HideBBVC.h"
#import "RoutePointsCartesian.h"

@interface StartRunningVC : HideBBVC <UITableViewDataSource , UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *routesTableView;
@property (weak, nonatomic) IBOutlet UIImageView *routeView;
@property UIImageView *selectedRouteView;
@property UserData *userData;

@end
