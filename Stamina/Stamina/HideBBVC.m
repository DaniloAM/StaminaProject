//
//  HideBBVC.m
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 09/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "HideBBVC.h"

@interface HideBBVC ()

@end

@implementation HideBBVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
    MenuShouldOpen *menu = [MenuShouldOpen alloc];
    [menu setOpen:NO];
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(voltaView)];
    [gesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:gesture];
}
-(void)voltaView{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    MenuShouldOpen *menu = [MenuShouldOpen alloc];
    [menu setOpen:YES];
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
