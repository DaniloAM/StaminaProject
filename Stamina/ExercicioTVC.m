//
//  CategoriaVC.m
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 10/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "ExercicioTVC.h"

@interface ExercicioTVC ()

@end

@implementation ExercicioTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTable:[[UITableView alloc] init]];
    self.table.delegate = self;
    self.table.dataSource=self;
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.table setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.table];
    [super criaBarButtonComBotoes:3];
    [super hideBar];
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //seconds
    lpgr.delegate = self;
    [self.table addGestureRecognizer:lpgr];


}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.table];
    
    NSIndexPath *indexPath = [self.table indexPathForRowAtPoint:p];
    if (indexPath == nil) {
        NSLog(@"long press on table view but not on a row");
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [super showBar];
        
        UITableViewCell *cell = [self.table cellForRowAtIndexPath:indexPath];
        if(cell.accessoryType == UITableViewCellAccessoryCheckmark){
            cell.accessoryType = UITableViewCellAccessoryNone;
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            [btn setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor blackColor ]];
            [cell addSubview:btn];
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;     
            
        }
    }else {
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGSize size = [[UIScreen mainScreen] bounds].size;
    [self.table setFrame:CGRectMake(0, 20, size.width, size.height- self.navigationController.navigationBar.frame.size.height)];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self arrayOfExercises] count]+2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
   
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if(indexPath.row >=[[self arrayOfExercises] count])
        return cell;
    Exercises *temp =[[self arrayOfExercises] objectAtIndex:indexPath.row];
        cell.textLabel.text = [temp name];
   
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *str = cell.textLabel.text;
    for (int x = 0; x < [[self arrayOfExercises] count]; x++) {
        
        Exercises *temp =[[self arrayOfExercises] objectAtIndex:x];
        if([[temp name] isEqualToString:str]){
            NSLog(@"achei vc amigao");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *myVC;
                myVC= (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TipsPVC"];
                
                [self.navigationController pushViewController:myVC animated:YES];
          return nil;
        }
    }
    return nil;
 
}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    _lastContentOffset = scrollView.contentOffset.y;
//}



//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    if (_lastContentOffset < (int)scrollView.contentOffset.y) {
//        
//    }
//    else if (_lastContentOffset > (int)scrollView.contentOffset.y) {
//    }
//    NSLog(@"%f", _lastContentOffset-scrollView.contentOffset.y);
//    float dy =_lastContentOffset -scrollView.contentOffset.y;
//    [self.tabBar setFrame:CGRectMake(0, self.tabBar.frame.origin.y-dy, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
//    _lastContentOffset = scrollView.contentOffset.y;
//    if(self.tabBar.frame.origin.y<self.startPointBar.y){
//        [self.tabBar setFrame:CGRectMake(0, self.startPointBar.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
//    }
//    else if(self.tabBar.frame.origin.y>self.startPointBar.y+self.tabBar.frame.size.height){
//        [self.tabBar setFrame:CGRectMake(0, self.startPointBar.y+self.tabBar.frame.size.height, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
//        
//    }
//    
//}
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    float scrollViewHeight = scrollView.frame.size.height;
//    float scrollContentSizeHeight = scrollView.contentSize.height;
//    float scrollOffset = scrollView.contentOffset.y;
//    
//    if (scrollOffset == 0)
//    {
//        NSLog(@"up");
//        [super hideBar];
//    }
//    else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
//    {
//        NSLog(@"up");
//        
//        [super showBar];
//    }
//
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//    screenSize.height = screenSize.height -self.navigationController.navigationBar.frame.size.height + 20
//    ;
//    
//    if(self.tabBar.frame.origin.y>self.startPointBar.y+self.tabBar.frame.size.height/2){
//        [UIView animateWithDuration:0.45 animations:^{
//            [self.tabBar setFrame:CGRectMake(0, self.startPointBar.y+self.tabBar.frame.size.height, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
//        }];
//        
//    }
//    else {
//        [UIView animateWithDuration:0.45 animations:^{
//            
//            
//            [self.tabBar setFrame:CGRectMake(0, self.startPointBar.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
//        }];
//        
//    }
//    
//    
//}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//    screenSize.height = screenSize.height -self.navigationController.navigationBar.frame.size.height + 20
//    ;
//    
//    if(self.tabBar.frame.origin.y>self.startPointBar.y+self.tabBar.frame.size.height/2){
//        [UIView animateWithDuration:0.45 animations:^{
//            [self.tabBar setFrame:CGRectMake(0, self.startPointBar.y+self.tabBar.frame.size.height, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
//        }];
//        
//    }
//    else {
//        [UIView animateWithDuration:0.45 animations:^{
//            
//            
//            [self.tabBar setFrame:CGRectMake(0, self.startPointBar.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
//        }];
//        
//    }
//    
//    
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
