//
//  PageContentViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{ 
    [super viewDidLoad];
    Cadastro *cd = [Cadastro alloc];
    [cd setShould:NO];
    [self txt1].layer.cornerRadius = 7 ;
    [self txt2].layer.cornerRadius = 7 ;
    [self txt3].layer.cornerRadius = 7 ;
    [self sexSegmented].hidden=YES;
    if([self pageIndex]==0){
        
        [self lblAux].hidden=YES;
        if([cd nome]){
            [self txt1].text = [cd nome];
        }
        if([cd nick]){
            [self txt2].text = [cd nick];
        }
        [self txt1].placeholder =@"Nome";
        [self txt2].placeholder =@"Nickname";
        [self txt3].hidden=YES;
    }
    else if([self pageIndex]==1){
        [self lblAux].hidden=YES;
        if([cd email]){
            [self txt1].text = [cd email];
            [self txt2].text = [cd email];
        }
        [self txt1].keyboardType = UIKeyboardTypeEmailAddress;
        [self txt2].keyboardType = UIKeyboardTypeEmailAddress;
        [self txt1].placeholder =@"Email";
        [self txt2].placeholder =@"Confirme o Email";
        [self txt3].hidden=YES;

    }
    else if([self pageIndex]==2){
        [self lblAux].hidden=YES;
        if([cd senha]){
            [self txt1].text = [cd senha];
            [self txt2].text = [cd senha];
        }
        [self txt1].placeholder =@"Senha";
        [self txt1].secureTextEntry = YES;
        [self txt2].secureTextEntry = YES;
        [self txt2].placeholder =@"Confirme a senha";
        [self txt3].hidden=YES;

    }
    else if([self pageIndex]==3){
        [self lblAux].text=@"Peso";
        if([cd peso]!=0){
            NSString *str = [NSString stringWithFormat:@"%d", (int)[cd peso]];
            [self txt3].text =str;

        }
        [self txt3].placeholder =@"Kg";
        [self txt2].hidden =YES;
        [self txt1].hidden =YES;

    }
    else if([self pageIndex]==4){
        if([cd altura]!=0){
            NSString *str = [NSString stringWithFormat:@"%d", [cd altura]];
            [self txt3].text =str;
            
        }
        [self lblAux].text=@"Altura";
        [self txt3].placeholder =@"Cm";
        [self txt2].hidden =YES;
        [self txt1].hidden =YES;
    }
    else if([self pageIndex]==5){
        if([cd idade]!=0){
            NSString *str = [NSString stringWithFormat:@"%d", [cd idade]];
            [self txt3].text =str;
            
        }
        [self lblAux].text=@"Idade";
        [self txt3].placeholder =@"Idade";
        [self txt2].hidden =YES;
        [self txt1].hidden =YES;
    }
    else if([self pageIndex]==6){
        [self sexSegmented].hidden=NO;
        [self lblAux].text=@"Sexo";
        [self txt2].hidden =YES;
        [self txt1].hidden =YES;
        [self txt3].hidden =YES;
        [self sexSegmented].userInteractionEnabled=YES;
        [self sexSegmented].selectedSegmentIndex = [cd sexo];
      
    }
    else if([self pageIndex]==7){
        [cd setShould:YES];
        [self sexSegmented].hidden=NO;
        [self lblAux].text=@"Erro tente novamente";
        [self txt2].hidden =YES;
        [self txt1].hidden =YES;
        [self txt3].hidden =YES;
        [self sexSegmented].hidden=YES;
        [self sexSegmented].selectedSegmentIndex = [cd sexo];
        [self presentError:0 :@"Loading"];
    }
}
-(IBAction)segmentedChartButtonChanged:(id)sender
{
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    Cadastro *cd = [Cadastro alloc];
    switch (segment.selectedSegmentIndex) {
        case 0:
            [cd setSexo:0];
            break;
        case 1:
            [cd setSexo:1];
            break;
        default:
            break;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    Cadastro *cd = [Cadastro alloc];
    if([self pageIndex]==0){
        if([self txt1].text && [self txt1].text.length > 0){
        [cd setNome: [[self txt1] text]];
        }
        else{
            [cd setNome: nil];
        }
        if([self txt2].text && [self txt2].text.length > 0){
            [cd setNick: [[self txt2] text]];

        }
        else {
            [cd setNick: nil];

        }
    }
    else if([self pageIndex]==1){
        if([self txt1].text && [self txt1].text.length > 0){
        if([[[self txt1] text] isEqualToString:[[self txt2] text]]){
            [cd setEmail:[[self txt1] text]];
        }
        }
        else
            [cd setEmail:nil];
        
    }
    else if([self pageIndex]==2){
        if([self txt1].text && [self txt1].text.length > 0){
        if([[[self txt1] text] isEqualToString:[[self txt2] text]]){
            [cd setSenha:[[self txt1] text]];
        }
        }
        else
            [cd setSenha:nil];

        
    }
    else if([self pageIndex]==3){
        [cd setPeso: [[[self txt3] text] floatValue]];

        
    }
    else if([self pageIndex]==4){
        [cd setAltura: [[[self txt3] text] intValue]];
    }
    else if([self pageIndex]==5){
        [cd setIdade: [[[self txt3] text] intValue]];
    }
    else if([self pageIndex]==6){


    }

    
}
-(void)presentError: (int) error : (NSString *)strError{
    
    ErrorVC *vc = [[ErrorVC alloc] initWithNibName:nil bundle:nil];
    RWBlurPopover *popover = [[RWBlurPopover alloc] initWithContentViewController:vc];
    [vc setError:error];
    [vc setStringError:strError];
    [self presentViewController:popover animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(IBAction)voltaLogin{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    [[self view] endEditing:YES];
    [self resignFirstResponder];
}

@end
