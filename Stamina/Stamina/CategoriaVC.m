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
    [self setFrontal:[NSArray arrayWithObjects:@"Abdominal",@"Ante-Braço",@"Bíceps",@"Peitoral",@"Quadríceps",@"Ombros",@"Trapézio",@"Tríceps", nil]];
    [self setTraseiro:[NSArray arrayWithObjects:@"Ante-Braço",@"Bíceps",@"Dorsal",@"Glúteos",@"Lombar",@"Ombros",@"Panturrilha",@"Posterior de Coxa", @"Rombóides",@"Trapézio",@"Tríceps",nil]];
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
{   NSArray *array;
    ExercisesList *temp = [ExercisesList alloc];
    if(indexPath.section==0){
        switch (indexPath.row) {
            case 0:
                array = [temp fr_abdominal];
                break;
            case 1:
                array = [temp fr_ante_braco];
                break;
            case 2:
                array = [temp fr_biceps];
                break;
            case 3:
                array = [temp fr_ombros];
                break;
            case 4:
                array = [temp fr_peitoral];
                break;
            case 5:
                array = [temp fr_quadriceps];
                break;
            case 6:
                array = [temp fr_trapezio];
                break;
            case 7:
                array = [temp fr_triceps];
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:
                array = [temp tr_ante_braco];
                break;
            case 1:
                array = [temp tr_biceps];
                
                break;
            case 2:
                array = [temp tr_dorsal];
                
                break;
            case 3:
                array = [temp tr_gluteos];
                
                break;
            case 4:
                array = [temp tr_lombar];
                
                break;
            case 5:
                array = [temp tr_ombros];
                
                break;
            case 6:
                array = [temp tr_panturrilha];
                
                break;
            case 7:
                array = [temp tr_posterior_de_coxa];
                
                break;
            case 8:
                array = [temp tr_romboides];
                
                break;
            case 9:
                array = [temp tr_trapezio];
                
                break;
            case 10:
                array = [temp tr_triceps];
                
                break;

                
        }
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ExercicioTVC *myVC;
    
    myVC= (ExercicioTVC *)[storyboard instantiateViewControllerWithIdentifier:@"ExercicioTVC"];
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
