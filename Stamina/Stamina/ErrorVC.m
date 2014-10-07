//
//  RWTestViewController.m
//  RWBlurPopoverDemo
//
//  Created by Zhang Bin on 2014-07-07.
//  Copyright (c) 2014年 Zhang Bin. All rights reserved.
//

#import "ErrorVC.h"

@interface ErrorVC ()

@end

@implementation ErrorVC

- (CGSize)preferredContentSize
{
       if([[self stringError]isEqualToString:@"Loading"]){
           [super view].userInteractionEnabled=NO;
       }return CGSizeMake(280, 160);
}
-(void)awakeFromNib{
    [super awakeFromNib];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self viewGeral].layer.cornerRadius = 7.0;
    [self btn].layer.cornerRadius = 7.0;
    [self indicator].hidden=YES;
    if([self stringError]){
        if([[self stringError]isEqualToString:@"Loading"]){
            [self.viewGeral setBackgroundColor:[UIColor clearColor]];
            [self lblError].hidden=YES;
            _indicator.hidden=NO;
            [_indicator  startAnimating];
            self.view.userInteractionEnabled=YES;
            [self btn].hidden = YES;
            [self carrega];
        }
        else
        [[self lblError] setText:[self stringError]];
    }
}
-(void)carrega{
    Cadastro *cd = [Cadastro alloc];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        NSString *s = [WebServiceResponse cadastrarComNome:[cd nome] eSenha:[cd senha] email:[cd email] sexo:[cd sexo] nickName:[cd nick]];
        while (1) {
            if (![s isEqualToString:@""]) {
                break;
            }
        }
        if([s isEqualToString:@"Adicionado"]||[s isEqualToString:@"1"]){
            
            [WebServiceResponse criaComEmail:[cd email] peso:[cd peso] sexo:[cd sexo] altura:[cd altura] idade:[cd idade]];
            [cd setStringResposta:s];
            }
        else {
            self.view.userInteractionEnabled =YES;
            [cd setStringResposta:s];

        }
        [self dismissViewControllerAnimated:NO completion:nil];

    });

}
-(IBAction)removeSuperview{
[self dismissViewControllerAnimated:NO completion:nil];}
@end
