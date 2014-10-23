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
    [self viewWillAppear:animated withGesture:1];
}
-(void)voltaView{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setTabBar:nil];

}
-(void)viewWillAppear:(BOOL)animated withGesture: (BOOL)gesture{
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
    MenuShouldOpen *menu = [MenuShouldOpen alloc];
    [menu setOpen:NO];
        _lastDirection = -1;
    
    if(gesture){
        UIPanGestureRecognizer *pangesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mecheu:)];
        [self setGesture:pangesture];
        [self.view addGestureRecognizer:pangesture];
        [super viewWillDisappear:animated];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    MenuShouldOpen *menu = [MenuShouldOpen alloc];
    [menu setOpen:YES];
    [super viewWillDisappear:animated];

    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSArray *)criaBarButtonComBotoes: (int)n{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    screenSize.height = screenSize.height -self.navigationController.navigationBar.frame.size.height + 20
    ;
    NSMutableArray *array = [NSMutableArray array];
    [self setTabBar:[[UIView alloc] initWithFrame:CGRectMake(0, screenSize.height-screenSize.height*145/1332 , screenSize.width, screenSize.height*145/1332 )]];
    [[self tabBar] setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.tabBar];
    [self setStartPointBar:self.tabBar.frame.origin];
    UISwipeGestureRecognizer *gest = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    [gest setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.tabBar addGestureRecognizer:gest];
    for(int x = 0 ; x < n; x++){
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(x*self.tabBar.frame.size.width/n, 0, self.tabBar.frame.size.width/n, self.tabBar.frame.size.height)];
        [self.tabBar addSubview:btn1];
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        [btn1 setBackgroundColor:color];
        [array addObject:btn1];
    }
    
    
    return array;
}
-(NSArray *)criaBarButtonComBotoesTranslucent: (int)n{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    screenSize.height = screenSize.height + 20
    ;
    NSMutableArray *array = [NSMutableArray array];
    [self setTabBar:[[UIView alloc] initWithFrame:CGRectMake(0, screenSize.height-screenSize.height*200/1571 , screenSize.width, screenSize.height*200/1571 )]];
    [[self tabBar] setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.tabBar];
    [self setStartPointBar:self.tabBar.frame.origin];
    for(int x = 0 ; x < n; x++){
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(x*self.tabBar.frame.size.width/n, 0, self.tabBar.frame.size.width/n, self.tabBar.frame.size.height)];
        [self.tabBar addSubview:btn1];
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        [btn1 setBackgroundColor:color];
        [array addObject:btn1];
    }
    
    return array;
}
-(void)mecheu :(UIPanGestureRecognizer *)sender{
    CGPoint velocity = [sender velocityInView:self.view];
    CGPoint stopLocation = [sender locationInView:self.view];

    if (sender.state == UIGestureRecognizerStateBegan) {
        if(fabs(velocity.x) > fabs(velocity.y)){
            if(velocity.x>0){
                [self setLastDirection:0];
            }
            else {
                _lastDirection = -1;
            }
            
        }
        else {
                _lastDirection = 1;
            self.point = stopLocation;
            
        }
    }
    
    if (sender.state == UIGestureRecognizerStateBegan) {
       
    }
    if(_lastDirection==0){
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    else if(_lastDirection==1&&self.tabBar!=nil){
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    screenSize.height = screenSize.height -self.navigationController.navigationBar.frame.size.height + 20
    ;
    
    CGFloat dy = stopLocation.y - self.point.y;
    CGPoint new;
    
    if (dy<0) {
        if (self.tabBar.frame.origin.y < self.startPointBar.y) {
            
        }
        else {
            new = self.tabBar.frame.origin;
            new.y = new.y +dy;
            [self.tabBar setFrame:CGRectMake(0, new.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
            
        }
        
    }
    else {
        if (self.tabBar.frame.origin.y >screenSize.height + self.tabBar.frame.size.height ) {
            
        }
        else {
            new = self.tabBar.frame.origin;
            new.y = new.y +dy;
            [self.tabBar setFrame:CGRectMake(0, new.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
            
        }
        
    }
    self.point = stopLocation;
    
    
    
    
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.tabBar.frame.origin.y <screenSize.height + self.tabBar.frame.size.height && self.tabBar.frame.origin.y > self.startPointBar.y) {
            if(self.tabBar.frame.origin.y>self.startPointBar.y+self.tabBar.frame.size.height/2){
                [self hideBar];
                
            }
            else {
                [self showBar];
            }
        }
    }
    if (self.tabBar.frame.origin.y < self.startPointBar.y) {
        [self.tabBar setFrame:CGRectMake(0, self.startPointBar.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    }
    }
}
-(void)hideBar{
    [UIView animateWithDuration:0.45 animations:^{
        [self.tabBar setFrame:CGRectMake(0, self.startPointBar.y+self.tabBar.frame.size.height, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    }];

}
-(void)showBar{
    [UIView animateWithDuration:0.45 animations:^{
        [self.tabBar setFrame:CGRectMake(0, self.startPointBar.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    }];
}
- (void)panRecognized:(UIPanGestureRecognizer *)rec
{
    CGPoint vel = [rec velocityInView:self.view];
    if (vel.y > 0)
    {
        [self hideBar];
    }
    else
    {
       
    }
}
@end
