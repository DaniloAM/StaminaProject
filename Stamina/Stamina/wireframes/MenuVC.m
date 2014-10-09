//
//  MenuVC.m
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 09/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "MenuVC.h"

@interface MenuVC ()

@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    height = height*167.67/1137.11;
    //
    
    CGFloat navBarHeight = height;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    
    //UILabel *labelText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, navBarHeight /4)];
    
    CGRect frame = CGRectMake(0.0f, 0.0f, width, navBarHeight);
    [self.navigationController.navigationBar setFrame:frame];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, navBarHeight /4, width, navBarHeight /4)];
    [label setTextAlignment:NSTextAlignmentCenter]; //to center text in the UILabel
    
    [label  setText:@"stamina.com"];
    [label setFont: [UIFont fontWithName:@"Helvetica" size:12]];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, label.frame.size.width, label.frame.size.height)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    UILabel *labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(0, navBarHeight /2, width, navBarHeight/2)];
    
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width*32/885, [[UIScreen mainScreen] bounds].size.height*143/1575, [[UIScreen mainScreen] bounds].size.width*80/885, [[UIScreen mainScreen] bounds].size.height*56/1575)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height)];
    imageView.image =[UIImage imageNamed:@"icon_menu.png"];
    [btn addSubview:imageView];
    [btn addTarget:mainVC action:@selector(openLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageViewLabelTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, labelTwo.frame.size.width, labelTwo.frame.size.height)];
    imageViewLabelTwo.image =[UIImage imageNamed:@"bg_bar.jpg"];
    [labelTwo addSubview:imageViewLabelTwo];
    [self.navigationController.navigationBar addSubview:label];
    [self.navigationController.navigationBar addSubview:labelTwo];
    [self.navigationController.navigationBar addSubview:btn];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end