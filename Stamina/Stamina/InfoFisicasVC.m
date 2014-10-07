//
//  InfoFisicasVC.m
//  Stamina
//
//  Created by João Lucas Sisanoski on 25/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "InfoFisicasVC.h"

@interface InfoFisicasVC ()

@end

@implementation InfoFisicasVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pesoTxt].layer.cornerRadius = 7 ;
    [self alturaTxt].layer.cornerRadius = 7 ;
    [self idadeTxt].layer.cornerRadius = 7 ;
    [self sexoTxt].layer.cornerRadius = 7 ;
    [self pesoTxt].delegate = self;
    [self alturaTxt].delegate = self;
    [self idadeTxt].delegate = self;
    [self sexoTxt].delegate = self;

}

-(IBAction)pular{
    
}
-(IBAction)salvar{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
    UserData *userData = [UserData alloc];
    NSString *str = [[self pesoTxt] text];
    
        if([str isEqualToString:@""]){
            [userData setWeightInKilograms:0];
        }
        else{
            [userData setWeightInKilograms:[str intValue]];
        }
    str = [[self alturaTxt] text];
  
    
        if([str isEqualToString:@""]){
            [userData setHeightInCentimeters:0];
        }
        else{
            [userData setHeightInCentimeters:[str intValue]];
        }
    [userData setAge:[[[self idadeTxt] text] intValue]];
    dispatch_async(dispatch_get_main_queue(), ^{

    NSString *s;
    s = [WebServiceResponse atualizaComEmail:[userData email] peso:[userData weightInKilograms] sexo:[userData sex] altura:[userData heightInCentimeters] idade:[userData age]];
    while (1) {
        
        if(s)
            break;
    }
    [self presentViewController:myVC animated:NO completion:nil];
        
    });
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self pesoTxt] resignFirstResponder];
    [[self alturaTxt] resignFirstResponder];
    [[self idadeTxt] resignFirstResponder];
    [[self sexoTxt] resignFirstResponder];
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
}
@end
