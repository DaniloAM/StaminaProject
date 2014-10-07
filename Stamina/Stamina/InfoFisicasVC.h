//
//  InfoFisicasVC.h
//  Stamina
//
//  Created by João Lucas Sisanoski on 25/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"
#import "WebServiceResponse.h"
@interface InfoFisicasVC : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *pesoTxt;
@property (weak, nonatomic) IBOutlet UITextField *alturaTxt;
@property (weak, nonatomic) IBOutlet UITextField *idadeTxt;
@property (weak, nonatomic) IBOutlet UITextField *sexoTxt;
-(IBAction)salvar;
@end
