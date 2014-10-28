//
//  CalendarInformationVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 24/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CalendarInformationVC.h"

@interface CalendarInformationVC ()

@end

@implementation CalendarInformationVC


-(void)receiveExercises: (NSArray *)exercises andDate: (NSDate *)date {
    
    _date = date;
    _exercisesList = exercises;
    
}


-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self exercisesTableView] setDelegate:self];
    [[self exercisesTableView] setDataSource:self];
    [[self exercisesTableView] setRowHeight:35.0];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[self date]];
    
    [[self dayLabel] setText:[NSString stringWithFormat:@"%d", (int)comp.day]];
    [[self yearLabel] setText:[NSString stringWithFormat:@"%d", (int)comp.year]];
    [[self monthLabel] setText:[CalendarMath returnMonthName:(int)comp.month]];
    
    [[self exercisesTableView] reloadData];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self exercisesList] count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString *text = [NSString stringWithFormat:@"%d. %@", (int)indexPath.row + 1, [[[self exercisesList] objectAtIndex:indexPath.row] name]];
    
    cell.textLabel.text = text;
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:20.0];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}







@end
