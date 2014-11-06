//
//  CriaTreinoVC.m
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 21/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CriaTreinoVC.h"

@interface CriaTreinoVC ()

@end

@implementation CriaTreinoVC

- (void)viewDidLoad {


    [super viewDidLoad];
    _selected =1;
    [self setInicio:nil];
    [self.view setBackgroundColor:[UIColor staminaYellowColor]];
       CreateTrainTemp *create = [CreateTrainTemp alloc];
    [create setName:[NSMutableArray array]];
    [create setIdentification:[NSMutableArray array]];
    [create setSer:[NSMutableArray array]];
    [create setRep:[NSMutableArray array]];
    _trainoNomeTxt.delegate = self;
    _tableExercicios.rowHeight = 30;
    _tableExercicios.delegate = self;
    _tableExercicios.dataSource = self;
    _tableExercicios.backgroundColor = [UIColor clearColor];
    _tableExercicios.contentSize = CGSizeMake(_tableExercicios.frame.size.width, [[create ser] count]*31);
    _arrayOfDays = [NSMutableArray array];

    for(int x = 0 ; x < 7; x++){
        NSNumber *num = [NSNumber numberWithInt:0];
        [_arrayOfDays addObject:num];
    }
    [_btnDias setBackgroundColor:[UIColor staminaBlackColor]];
    [_btnExercicio setBackgroundColor:[UIColor staminaBlackColor]];
    _btnExercicio.layer.cornerRadius = 7;
    _btnDias.layer.cornerRadius = 7;
    [[self viewDays] setBackgroundColor:[UIColor staminaBlackColor]];
    [self viewDays].layer.cornerRadius =7;
    for(UIView *btn in [[self viewDays] subviews]){
        if([btn isKindOfClass:[UIButton class]]){
        [btn layer].cornerRadius = 7;
        [btn.layer setBorderWidth:1.0f];
        [btn layer].borderColor = [UIColor staminaYellowColor].CGColor;
        }
    }
    _inicioHoraTxt.layer.cornerRadius =7;
    _trainoNomeTxt.layer.cornerRadius = 7;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self firstButtonMethod:@selector(function1) withImage:nil];

}
-(NSNumber *)checkAndChange: (NSNumber *)number andButton :(UIButton *)btn{
    int x = [number intValue];
    if(x ==1){
        [btn setBackgroundColor:[UIColor staminaBlackColor]];
        [btn layer].borderColor = [UIColor staminaYellowColor].CGColor;
        [btn setTitleColor:[UIColor staminaYellowColor] forState:UIControlStateNormal];
        return [NSNumber numberWithInt:0];
        
    }
    else{
        [btn setBackgroundColor:[UIColor staminaYellowColor]];
        [btn layer].borderColor = [UIColor staminaBlackColor].CGColor;
                [btn setTitleColor:[UIColor staminaBlackColor] forState:UIControlStateNormal];
        return [NSNumber numberWithInt:1];
    }
}
-(IBAction)seg : (UIButton *)sender{
    [[self arrayOfDays] replaceObjectAtIndex:1 withObject:[self checkAndChange:[[self arrayOfDays] objectAtIndex:1] andButton:sender]];

    
}
-(IBAction)ter: (UIButton *)sender{
    [[self arrayOfDays] replaceObjectAtIndex:2 withObject:[self checkAndChange:[[self arrayOfDays] objectAtIndex:2] andButton:sender]];
;
    
}
-(IBAction)qua: (UIButton *)sender{
    [[self arrayOfDays] replaceObjectAtIndex:3 withObject:[self checkAndChange:[[self arrayOfDays] objectAtIndex:3] andButton:sender]];

    
}
-(IBAction)qui: (UIButton *)sender{
    [[self arrayOfDays] replaceObjectAtIndex:4 withObject:[self checkAndChange:[[self arrayOfDays] objectAtIndex:4] andButton:sender]];

    
}
-(IBAction)sex: (UIButton *)sender{
    [[self arrayOfDays] replaceObjectAtIndex:5 withObject:[self checkAndChange:[[self arrayOfDays] objectAtIndex:5] andButton:sender]];

    
}
-(IBAction)sab: (UIButton *)sender{
    [[self arrayOfDays] replaceObjectAtIndex:6 withObject:[self checkAndChange:[[self arrayOfDays] objectAtIndex:6] andButton:sender]];

    
}
-(IBAction)dom: (UIButton *)sender{
    [[self arrayOfDays] replaceObjectAtIndex:0 withObject:[self checkAndChange:[[self arrayOfDays] objectAtIndex:0] andButton:sender]];

    
}

-(void)function1{
    CreateTrainTemp *create = [CreateTrainTemp alloc];
    [create setTrainingName:[[self trainoNomeTxt] text]];

    if([[create ser] count]==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Adicione ao menos um exercicio." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (create.trainingName.length == 0)
    {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Cheque o nome do treino." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
   
    AppDelegate *delegate= [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    if([create trainingName])
    for (int x = 0; x < [[create name] count];x++){
        TrainingExercises *exercise = [NSEntityDescription insertNewObjectForEntityForName:@"TrainingExercises" inManagedObjectContext:context];
        NSNumber *rep = [NSNumber numberWithInt:[[[create rep] objectAtIndex:x] intValue]];
        NSNumber *ser = [NSNumber numberWithInt:[[[create ser] objectAtIndex:x] intValue]];
        NSNumber *identification = [NSNumber numberWithInt:[[[create identification] objectAtIndex:x] intValue]];
        [exercise setRepetitions:rep];
        [exercise setId_exercise:identification];
        [exercise setSeries:ser];
        [exercise setTraining_name:[create trainingName]];
        
        NSError *error;
        
        [context save:&error];
    }
    [[create ser] removeAllObjects];
        [[create rep] removeAllObjects];
        [[create identification] removeAllObjects];
    [create setTrainingName:nil];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.trainoNomeTxt resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}
-(IBAction)btn1 : (UIButton *)sender{
    _selected = 0;
    [self atualiza];
}
-(IBAction)btn2 : (UIButton *)sender{
    _selected = 1;
        [self atualiza];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CreateTrainTemp *tem = [CreateTrainTemp alloc];

    return [[tem ser] count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:0.45 animations:^{
        self.btn.transform =CGAffineTransformMakeRotation(-3.14/2);

    }];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier;
    CreateTrainTemp *temp = [CreateTrainTemp  alloc];
 
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    NSString *str = [NSString stringWithFormat:@"%@ - %@x%@",[[temp name] objectAtIndex:indexPath.row],[[temp ser] objectAtIndex:indexPath.row],[[temp rep] objectAtIndex:indexPath.row]];
    cell.textLabel.text = str;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    return cell;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self trainoNomeTxt] layer].cornerRadius = 7;
    [[self btnDias] layer].cornerRadius =7;
    [[self btnExercicio] layer].cornerRadius =7;
    [[self inicioHoraTxt] layer].cornerRadius =7;
    [[self trainoNomeTxt] setPlaceholder:@"     Qual o nome do treino ?"];
    _datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 250, 200)];
    _datepicker.datePickerMode = UIDatePickerModeTime;
    self.navigationController.navigationBar.translucent = YES;
    [_tableExercicios reloadData];
    [self atualiza];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;

}
-(IBAction)horaInicial: (id)sender{
    [self launchDialog:sender];
}

- (void)launchDialog:(id)sender
{

    
    
    // Here we need to pass a full frame
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"OK",nil]];
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
        NSDate *myDate = _datepicker.date;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm"];
        NSString *dateString = [dateFormat stringFromDate:myDate];
        [[self inicioHoraTxt] setTitle:dateString forState:UIControlStateNormal];
    [alertView close];

}
-(void)atualiza{

      

    if(!_selected){
        [self viewDays].hidden = NO;
        [self tableExercicios].hidden = YES;
        [self viewAux2].backgroundColor = [UIColor staminaBlackColor];
        [self viewAux3].backgroundColor = [UIColor staminaYellowColor];
        self.viewAux5.hidden = NO;
        self.viewAux4.hidden = YES;
    }
    
    else {
        [self viewDays].hidden = YES;
        [self tableExercicios].hidden = NO;
        [self viewAux3].backgroundColor = [UIColor staminaBlackColor];
        [self viewAux2].backgroundColor = [UIColor staminaYellowColor];
        self.viewAux5.hidden = YES;
        self.viewAux4.hidden = NO;
    }
   
}
- (UIView *)createDemoView
{
    
    
    return _datepicker;
}


-(IBAction)mostraListaExercicios{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC;
    myVC= (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CategoriaTVC"];
    CreateTrainTemp *temp = [CreateTrainTemp alloc];
    [temp setTrainingName:[[self trainoNomeTxt] text]];
    [self.navigationController pushViewController:myVC animated:YES];
}
@end
