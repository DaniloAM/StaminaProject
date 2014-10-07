//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Cadastro.h"
#import "RWBlurPopover.h"

@interface PageContentViewController : UIViewController

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@property (weak, nonatomic) IBOutlet UITextField *txt1;
@property (weak, nonatomic) IBOutlet UITextField *txt2;
@property (weak, nonatomic) IBOutlet UITextField *txt3;
@property (weak, nonatomic) IBOutlet UILabel *lblAux;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegmented;
@end
