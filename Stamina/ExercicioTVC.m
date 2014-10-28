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
    NSArray *array =  [super criaBarButton];
    CreateTrainTemp *exe = [CreateTrainTemp alloc];
    if(![exe arrayOfExercises]){
        [exe setArrayOfExercises:[NSMutableArray array]];
    }
    UIButton *btn = [array objectAtIndex:0];
    
    [btn addTarget:self action:@selector(function1) forControlEvents:UIControlEventTouchUpInside];
    btn = [array objectAtIndex:1];
  //  [btn addTarget:self action:@selector(adicionaTreino) forControlEvents:UIControlEventTouchUpInside];
    btn = [array objectAtIndex:2];
    [btn addTarget:self action:@selector(adicionaTreino) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor    blackColor]];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.height*0.85, btn.frame.size.height*0.85)];
    [image  setImage:[UIImage imageNamed:@"icone_ok.png"]];
    [btn addSubview:image];
    [image setCenter:CGPointMake(btn.frame.size.width/2, btn.frame.size.height/2)];
    [super hideBarWithAnimation:1];
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //seconds
    lpgr.delegate = self;
    [self.table addGestureRecognizer:lpgr];
    [self showBarWithAnimation:YES];


}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.table];
    CreateTrainTemp *temp = [CreateTrainTemp alloc];
    NSIndexPath *indexPath = [self.table indexPathForRowAtPoint:p];
    if (indexPath == nil) {
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [super showBarWithAnimation:YES];
        UITableViewCell *cell = [self.table cellForRowAtIndexPath:indexPath];
        Exercises *exe = [self retornaExercicioComNome:cell.textLabel.text];
        
        if(cell.accessoryType == UITableViewCellAccessoryCheckmark){
            cell.accessoryType = UITableViewCellAccessoryNone;
            [[temp arrayOfExercises]removeObject:exe];
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;     
            [[temp arrayOfExercises] addObject:exe];
        }
    }else {
    }
}
-(void)adicionaTreino{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC;
    myVC= (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AddExercise"];
    [self.navigationController pushViewController:myVC animated:YES];

}
-(void)function1{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    
    CreateTrainTemp *te = [CreateTrainTemp alloc];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
   
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if(indexPath.row >=[[self arrayOfExercises] count])
        return cell;
    Exercises *temp =[[self arrayOfExercises] objectAtIndex:indexPath.row];
        cell.textLabel.text = [temp name];
    for (Exercises *exe in [te arrayOfExercises]) {
        if(exe == temp){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            return cell;
        }
    }
   
    return cell;
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
}
-(Exercises *)retornaExercicioComNome : (NSString   *)nome{
    for (int x = 0; x < [[self arrayOfExercises] count]; x++) {
        
        Exercises *temp =[[self arrayOfExercises] objectAtIndex:x];
        if([[temp name] isEqualToString:nome]){
            return temp;
        }

    }
    return nil;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *str = cell.textLabel.text;
    
            Exercises *temp =[self retornaExercicioComNome:str];
    
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *myVC;
                myVC= (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TipsPVC"];
                [self.navigationController pushViewController:myVC animated:YES];
    
    return nil;
 
}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    _lastContentOffset = scrollView.contentOffset.y;
//}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [self hideBarWithAnimation:1];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self showBarWithAnimation:YES];
}

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
