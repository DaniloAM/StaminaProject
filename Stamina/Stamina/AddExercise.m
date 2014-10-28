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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSArray *array =  [super criaBarButton];
    
    UIButton *btn = [array objectAtIndex:0];
    [btn addTarget:self action:@selector(function1) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [array objectAtIndex:1];
    [btn addTarget:self action:@selector(function2) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [array objectAtIndex:2];
    [btn addTarget:self action:@selector(function3) forControlEvents:UIControlEventTouchUpInside];
    [self adicionaImagem:[UIImage imageNamed:@"icone_ok.png"] paraOBotao:btn];
    _currentIndex = 0;
    [self showTheRightExercise:0];
}
-(void)adicionaImagem : (UIImage *)image paraOBotao : (UIButton *)btn{
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.height*0.75, btn.frame.size.height*0.75)];
    [image2  setImage:image];
    [btn setBackgroundColor:[UIColor    blackColor]];
    [btn addSubview:image2];
    [image2 setCenter:CGPointMake(btn.frame.size.width/2, btn.frame.size.height/2)];

}
-(void)function1{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)function2{
}
-(void)function3{
    [self showTheRightExercise:_currentIndex];
    _currentIndex++;
}
-(void)showTheRightExercise : (int )x{
    CreateTrainTemp *temp = [CreateTrainTemp alloc];
    if(x >= [[temp arrayOfExercises] count])
        return;
    Exercises *exe = [[temp arrayOfExercises] objectAtIndex:x];
    [[self exerciseName] setText:exe.name];
    [[self categoriaName] setText:[ExercisesList returnCategoryNameWithId:(int)exe.exerciseID]];
    
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
