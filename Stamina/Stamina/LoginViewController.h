//
//  LoginViewController.h
//  Stamina
//
//  Created by João Lucas Sisanoski on 19/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceResponse.h"
#import "UserData.h"
#import "ErrorVC.h"
#import "RWBlurPopover.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *signInBTN;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UIView *viewBlock;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIButton *cadastreSeBTN;
@property (strong, nonatomic) IBOutlet UIView *viewTotal;
@property BOOL down;
@property (weak, nonatomic) IBOutlet UIButton *fbBTN;

@end
