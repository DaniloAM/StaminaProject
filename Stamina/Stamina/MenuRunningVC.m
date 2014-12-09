//
//  MenuRunningVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 28/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "MenuRunningVC.h"

@interface MenuRunningVC ()

@end

@implementation MenuRunningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *date = [NSDate date];
     NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitDay fromDate:date];
    
    [[self calendarIcon] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icone_calendario_%02d.png", (int) comp.day]]];

    
    UISwipeGestureRecognizer *backGest = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backToHomeScreen)];
    
    backGest.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:backGest];
    
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self performSelectorInBackground:@selector(showCurrentWeather) withObject:nil];
}


-(void)showCurrentWeather {
    
    WeatherCondition *condition = [[WeatherCondition alloc] init];
    
    NSInteger temperature = [condition returnTemperatureInCurrentLocation];
    
    if(temperature <= 0) {
        [[self temperatureLabel] setHidden:true];
        [[self temperatureImage] setHidden:true];
        
    }
    
    else {
        [[self temperatureLabel] setHidden:false];
        [[self temperatureImage] setHidden:false];
        
        temperature -= 273;
        
        NSString *temp = [NSString stringWithFormat:@"%d °C", (int) temperature];
        [[self temperatureLabel] setText:temp];
    }
    
}


-(void)backToHomeScreen {
    
    [self.navigationController popToRootViewControllerAnimated:true];
    
}




@end
