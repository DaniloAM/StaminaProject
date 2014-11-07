//
//  ExerciseToAddVC.m
//  Stamina
//
//  Created by João Lucas Sisanoski on 07/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "ExerciseToAddVC.h"
#define heightAi 1005
#define widthAi 640

@interface ExerciseToAddVC ()

@end

@implementation ExerciseToAddVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor staminaYellowColor]];
    [self initialingView];
    
}
-(void)initialingView{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    _gifExplain = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height*410/heightAi)];
    [_gifExplain setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_gifExplain];
    
    _exerciseName = [[UILabel alloc] initWithFrame:CGRectMake(size.width*71/widthAi, 440*size.height/heightAi, size.width,  45*size.height/heightAi)];
    [_exerciseName setText:@"Exercicio 1"];
    [_exerciseName setFont:[UIFont fontWithName:@"Avenir" size:22]];
    [self.view addSubview:_exerciseName];
    _categoriaName = [[UILabel alloc] initWithFrame:CGRectMake(size.width*71/widthAi, 500*size.height/heightAi, size.width,  45*size.height/heightAi)];
    [_categoriaName setText:@"Categoria"];
       [_categoriaName setFont:[UIFont fontWithName:@"Avenir" size:18]];
    [self.view addSubview:_categoriaName];
    _cronometer = [[UIImageView alloc] initWithFrame:CGRectMake(87*size.width/widthAi, 610*size.height/heightAi, 76*size.height/heightAi, 76*size.height/heightAi)];
    [_cronometer setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_cronometer];
    _repetitions= [[UIImageView alloc] initWithFrame:CGRectMake(87*size.width/widthAi, 720*size.height/heightAi, 76*size.height/heightAi, 76*size.height/heightAi)];
    [_repetitions setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_repetitions];
//    @property UIImageView *gifExplain, *cronometer, *repetitions;
//    @property UILabel *exerciseName, *categoriaName;
//    @property UITextField *txtSer, *txtRep, *txtTime;

}

@end
