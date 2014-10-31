//
//  CriaTreinoVC.h
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 21/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "HideBBVC.h"
#import "CustomIOS7AlertView.h"
#import "CreateTrainTemp.h"
#import "AppDelegate.h"
#import "TrainingExercises.h"
@interface CriaTreinoVC : HideBBVC <CustomIOS7AlertViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *trainoNomeTxt;
@property (weak, nonatomic) IBOutlet UIButton *btnDias;
@property (weak, nonatomic) IBOutlet UIButton *btnExercicio;
@property (weak, nonatomic) IBOutlet UITableView *tableExercicios;
@property (weak, nonatomic) IBOutlet UIButton *inicioHoraTxt;
@property UIDatePicker *datepicker;
@property NSDate *inicio;
@property int sender;
@property UIAlertView *alert;
@property (weak, nonatomic) IBOutlet UILabel *labelVazio;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end
