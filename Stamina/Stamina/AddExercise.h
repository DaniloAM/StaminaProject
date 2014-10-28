//
//  AddExercise.h
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 24/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "HideBBVC.h"
#import "CreateTrainTemp.h"
#import "Exercises.h"
#import "ExercisesList.h"

@interface AddExercise : HideBBVC
@property (weak, nonatomic) IBOutlet UITextField *txtSeries;
@property (weak, nonatomic) IBOutlet UITextField *txtRep;
@property (weak, nonatomic) IBOutlet UILabel *exerciseName;
@property (weak, nonatomic) IBOutlet UILabel *categoriaName;
@property int currentIndex;
@end
