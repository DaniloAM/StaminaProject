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
    [self setInicio:nil];

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
    [self labelVazio].hidden = YES;

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self firstButtonMethod:@selector(function1) withImage:nil];

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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CreateTrainTemp *tem = [CreateTrainTemp alloc];
    if([[tem ser] count]==0){
        [self labelVazio].hidden = NO;
        [self tableExercicios].hidden=YES;
    }
    else {
        [self labelVazio].hidden = YES;
        [self tableExercicios].hidden=NO;
    }
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
