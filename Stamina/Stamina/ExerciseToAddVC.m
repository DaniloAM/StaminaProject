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
    _selected = 1;

    [self atualiza];

}
-(void)atualiza{
    if(_selected){
        _txtTime.hidden=YES;
        _txtSer.hidden=NO;
        _txtRep.hidden=NO;
        [self showView:_viewAux1];
        [self hideView:_viewAux2];
    }
    else {
        _txtTime.hidden=NO;
        _txtSer.hidden=YES;
        _txtRep.hidden=YES;



        [self hideView:_viewAux1];
        [self showView:_viewAux2];

    }
}
-(void)hideView :(UIView *)view{
    [UIView animateWithDuration:0.5
                     animations:^{
                         view.alpha=0;
                     }
                     completion:^(BOOL finished){
                         // Do other things
                     }];
}
-(void)showView: (UIView *)view{
    [UIView animateWithDuration:0.5
                     animations:^{
                         view.alpha=1;
                     }
                     completion:^(BOOL finished){
                         // Do other things
                     }];
}
-(void)initialingView{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    size.height = size.height-[self navigationSize].height;
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(189*size.width/widthAi, 595*size.height/heightAi, 389*size.width/widthAi, 227*size.height/heightAi)];
    _view1.layer.cornerRadius = 7;
    [self.view addSubview:_view1];
    _cronometerView = [[UIView alloc] initWithFrame:CGRectMake(67*size.width/widthAi, 595*size.height/heightAi, 118*size.width/widthAi, 123*size.width/widthAi)];
    [_cronometerView setBackgroundColor:[UIColor staminaBlackColor] ];
    [self.view addSubview:_cronometerView];
    
    
    _repetitionView = [[UIView alloc] initWithFrame:CGRectMake(67*size.width/widthAi,595*size.height/heightAi+227*size.height/heightAi-123*size.width/widthAi, 118*size.width/widthAi, 123*size.width/widthAi)];
    [_repetitionView setBackgroundColor:[UIColor staminaBlackColor]];
    
    [self.view addSubview:_repetitionView];
    
    [_view1 setBackgroundColor:[UIColor staminaBlackColor]];
    
    
    _viewAux1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [_viewAux1 setBackgroundColor:[UIColor staminaBlackColor]];
    [_view1 addSubview:_viewAux1];
    
    _viewAux2 = [[UIView alloc] initWithFrame:CGRectMake(0,227*size.height/heightAi-20, 20, 20)];
    [_viewAux2 setBackgroundColor:[UIColor staminaBlackColor]];
    
    [_view1 addSubview:_viewAux2];
    
    
    
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
    _cronometer = [[UIButton alloc] initWithFrame:CGRectMake(87*size.width/widthAi, 610*size.height/heightAi, 76*size.height/heightAi, 76*size.height/heightAi)];
    [_cronometer setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_cronometer];
    _repetitions= [[UIButton alloc] initWithFrame:CGRectMake(87*size.width/widthAi, 720*size.height/heightAi, 76*size.height/heightAi, 76*size.height/heightAi)];
    [_repetitions setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_repetitions];
    
    _txtSer = [[UITextField alloc] initWithFrame:CGRectMake(216*size.width/widthAi, 640*size.height/heightAi, 125*size.height/heightAi, 125*size.height/heightAi)];
    [self.view addSubview:_txtSer];
    _txtSer.backgroundColor = [UIColor whiteColor];
    
    _txtSer.layer.cornerRadius = 7;

    
    
    _txtRep = [[UITextField alloc] initWithFrame:CGRectMake(412*size.width/widthAi, 640*size.height/heightAi, 125*size.height/heightAi, 125*size.height/heightAi)];
    [self.view addSubview:_txtRep];
    _txtRep.backgroundColor = [UIColor whiteColor];
    _txtRep.layer.cornerRadius = 7;
    
    _x = [[UILabel alloc] initWithFrame:CGRectMake(371*size.width/widthAi, 680*size.height/heightAi, 24*size.height/heightAi, 24*size.height/heightAi)];
    [_x setText:@"X"];
    [_x setFont:[UIFont fontWithName:@"Avenir" size:22]];
    [_x setTextColor:[UIColor staminaBlackColor]];
    [self.view addSubview:_x];
    
    
    _txtTime =[[UITextField alloc] initWithFrame:CGRectMake(218*size.width/widthAi, 640*size.height/heightAi, 206*size.height/heightAi, 125*size.height/heightAi)];
    [self.view addSubview:_txtTime];
    _txtTime.backgroundColor = [UIColor whiteColor];
    _txtTime.layer.cornerRadius = 7;

    
    [_cronometer setCenter:_cronometerView.center];
    [_repetitions setCenter:_repetitionView.center];
    [_cronometer addTarget:self action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
    [_repetitions addTarget:self action:@selector(button2) forControlEvents:UIControlEventTouchUpInside];

}
-(void)button1{
    _selected=1;
    NSLog(@"");
    [self atualiza];
}
-(void)button2{
    _selected=0;

    NSLog(@"");
    [self atualiza];
}
@end
