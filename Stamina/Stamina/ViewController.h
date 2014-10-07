//
//  ViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import "Cadastro.h"
#import "ErrorVC.h"
#import "RWBlurPopover.h"
#import "WebServiceResponse.h"
#import "Reachability.h"
@interface ViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property int index;
@property (weak, nonatomic) IBOutlet UIPageControl *bar;

-(IBAction)login;

@end
