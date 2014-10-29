//
//  AddExercise.m
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 24/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "AddExercise.h"

@interface AddExercise ()

@end

@implementation AddExercise


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CreateTrainTemp *create = [CreateTrainTemp alloc];
    [super viewDidAppear:animated];
    NSArray *array =  [super criaBarButton];
        UIButton *btn = [array objectAtIndex:0];
    [btn addTarget:self action:@selector(function1) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [array objectAtIndex:1];
    [btn addTarget:self action:@selector(function2) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [array objectAtIndex:2];
    [btn addTarget:self action:@selector(function3) forControlEvents:UIControlEventTouchUpInside];

    _currentIndex = 1;
    Exercises *first = [[create arrayOfExercises] firstObject];
    [[self exerciseName] setText:first.name];
    [[self categoriaName] setText:[ExercisesList returnCategoryNameWithId:[first.exerciseID intValue]]];

    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.txtRep resignFirstResponder];
    [self.txtSeries resignFirstResponder];
}

-(void)function1{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)function2{
}
-(void)function3{
    [self showTheRightExercise];
}

-(void)showTheRightExercise{
    CreateTrainTemp *temp = [CreateTrainTemp alloc];
    int rep = [[self.txtRep text] intValue];
    int ser = [[self.txtSeries text] intValue];
    if(!rep||!ser){
        return;
    }
    if([[temp arrayOfExercises] count]==1){
        Exercises *exe = [[temp arrayOfExercises] firstObject];
        [[temp rep] addObject:[self.txtRep text]];
        [[temp ser] addObject:[self.txtSeries text]];
        [[temp identification] addObject:exe.exerciseID];
        [[temp arrayOfExercises] removeObject:exe];
        [[temp name] addObject:exe.name];

        [self returnView];
        return;
    }
    
    
    Exercises *exe = [[temp arrayOfExercises] firstObject];

    [[temp rep] addObject:[self.txtRep text]];
    [[temp ser] addObject:[self.txtSeries text]];
    [[temp identification] addObject:exe.exerciseID];
    [[temp name] addObject:exe.name];
    [[temp arrayOfExercises] removeObject:exe];
    exe = [[temp arrayOfExercises] firstObject];
    [[self exerciseName] setText:exe.name];
    [[self categoriaName] setText:[ExercisesList returnCategoryNameWithId:[exe.exerciseID intValue]]];
    [[self txtSeries] setText:@""];
    [[self txtRep] setText:@""];
}

-(void)returnView{
    
    UIViewController *View = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-4];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController popToViewController:View animated:YES];
    
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
