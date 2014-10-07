//
//  RWTestViewController.h
//  RWBlurPopoverDemo
//
//  Created by Zhang Bin on 2014-07-07.
//  Copyright (c) 2014年 Zhang Bin. All rights reserved.
//

@import UIKit;
#import "WebServiceResponse.h"
#import "Cadastro.h"
@interface ErrorVC : UIViewController
@property int error;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
@property NSString *stringError;
@property (strong, nonatomic) IBOutlet UIView *viewGeral;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@end
