//
//  CategoriaVC.m
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 10/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CategoriaVC.h"

@interface CategoriaVC ()

@end

@implementation CategoriaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFrontal:[NSArray arrayWithObjects:@"Abdominal",@"Ante-Braço",@"Bíceps",@"Ombros",@"Peitoral",@"Quadríceps",@"Trapézio",@"Tríceps", nil]];
    [self setTraseiro:[NSArray arrayWithObjects:@"Ante-Braço",@"Bíceps",@"Dorsal",@"Glúteos",@"Lombar",@"Ombros",@"Panturrilha",@"Posterior de Coxa", @"Rombóides",@"Trapézio",@"Tríceps",@"",@"",nil]];
    self.table.delegate = self;
    self.table.dataSource=self;
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.table setBackgroundColor:[UIColor clearColor]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGSize size = [[UIScreen mainScreen] bounds].size;
    [self.table setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, size.width, size.height- self.navigationController.navigationBar.frame.size.height)];
    
    [self removeGestureFromMenuVC];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return [[self frontal] count];
    }
    
    return [[self traseiro] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if(indexPath.section==0){
        cell.textLabel.text = [[self frontal] objectAtIndex:indexPath.row];
    }
    else {
        cell.textLabel.text = [[self traseiro] objectAtIndex:indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}
- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Frontal", @"Frontal");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Traseiro", @"Traseiro");
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ExercicioTVC *myVC;
    
    myVC= (ExercicioTVC *)[storyboard instantiateViewControllerWithIdentifier:@"ExercicioTVC"];
    NSArray *array;
    ExercisesList *temp = [ExercisesList alloc];
    if(indexPath.section==0){
        
        array = [[temp exercisesMatrix] objectAtIndex:indexPath.row + 1];
        
    }
    else{
        array = [[temp exercisesMatrix] objectAtIndex:indexPath.row + frontalCategoryCount + 1];
        
    }
    [myVC setArrayOfExercises:array];

    [self.navigationController pushViewController:myVC animated:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    //Set the background color of the View
    view.tintColor = [UIColor blackColor];
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor colorWithRed:250 green:217 blue:0 alpha:1]];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [super hideBarWithAnimation:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [super showBarWithAnimation:YES];
}

@end
