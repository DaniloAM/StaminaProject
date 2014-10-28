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
    [self setFim:nil];
    NSArray *array = [super criaBarButton];
    UIButton *btn = [array firstObject];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.height, btn.frame.size.height)];
    [image  setImage:[UIImage imageNamed:@"icone_ok.png"]];
    [btn addSubview:image];
    [image setCenter:CGPointMake(btn.frame.size.width/2, btn.frame.size.height/2)];

    self.navigationController.navigationBar.translucent = YES;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self trainoNomeTxt] layer].cornerRadius = 7;
    [[self btnDias] layer].cornerRadius =7;
    [[self btnExercicio] layer].cornerRadius =7;
    [[self inicioHoraTxt] layer].cornerRadius =7;
    [[self fimHoraTxt] layer].cornerRadius =7;
    [[self trainoNomeTxt] setPlaceholder:@"     Qual o nome do treino ?"];
    _datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 250, 200)];
    _datepicker.datePickerMode = UIDatePickerModeTime;
    self.navigationController.navigationBar.translucent = YES;
    


}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;

}
-(IBAction)horaInicial: (id)sender{
    [self launchDialog:sender];
}
-(IBAction)horaFinal: (id)sender{
    [self launchDialog:sender];

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
- (void)launchDialog:(id)sender
{
   if(sender == [self inicioHoraTxt]){
       [self setSender:1];
    }
    else if(sender == [self fimHoraTxt]){
        [self setSender:2];

    }
    
    
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
-(void)checkTempo{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:_datepicker.date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"hh:mm a"];
    NSString *timetofill, *min, *hou;
    if([[[NSLocale preferredLanguages] firstObject] isEqualToString:@"pt"]){
        min =[NSString stringWithFormat:@"%02d", (int)minute];
        hou = [NSString stringWithFormat:@"%02d", (int)hour];
        
        timetofill = [NSString stringWithFormat:@"%@:%@",hou,min];
    }
    else {
        timetofill = [outputFormatter stringFromDate:_datepicker.date];
        
    }
    
    if([self sender]==1){
        [[self inicioHoraTxt] setTitle:timetofill forState:UIControlStateNormal];
        [self setInicio:_datepicker.date];
    }
    else if([self sender]==2){
        [[self fimHoraTxt] setTitle:timetofill forState:UIControlStateNormal];
        [self setFim:_datepicker.date];
        
    }
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{   [self checkTempo];
    
    if([self inicio]!=nil && [self fim]!=nil){
            int x =[self returnDiferenceBetween:_inicio andDate2:_fim];
        if(x/60>3){
            NSString *str = [NSString stringWithFormat:@"Você realmente vai malhar por %d horas ?", x/60];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Quanto tempo!" message:str delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
            _alert = alert;
            [alert show];
            return;
        }
        if(x/60<=0){
            NSString *str = [NSString stringWithFormat:@"Você realmente vai somente por menos de uma hora ?"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Quanto tempo!" message:str delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
            [alert show];
            return;

        }
    }
    [alertView close];

}
-(int)returnDiferenceBetween: (NSDate *)date1 andDate2: (NSDate *)date2{
    int dif= [date2 timeIntervalSinceDate:date1];
   
    if(dif<0){
        NSDate *newDate1 = [date2 dateByAddingTimeInterval:60*60*24];
        return [self returnDiferenceBetween:date1 andDate2:newDate1];
        
    }
    return dif/60;

}
- (UIView *)createDemoView
{
    
    
    return _datepicker;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if(alertView==_alert){
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parabens!" message:@"Continue assim!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [self checkTempo];
    }
    else
    {
        //User clicked cancel
        [[self fimHoraTxt] setTitle:[[[self inicioHoraTxt] titleLabel] text] forState:UIControlStateNormal];
        
    }
    }
}

-(IBAction)mostraListaExercicios{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC;
    myVC= (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CategoriaTVC"];
    
    [self.navigationController pushViewController:myVC animated:YES];
}
@end
