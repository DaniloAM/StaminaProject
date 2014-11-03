//
//  CadastroVC.h
//  Stamina
//
//  Created by João Lucas Sisanoski on 03/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CadastroVC : UIViewController <UIScrollViewDelegate, UITextFieldDelegate>
@property UIScrollView *scroll;
@property float lastContentOffset;
@property int currentIndex;
@property int numberOfViews;
@property UITextField *txtName, *txtNick, *txtEmail, *txtConfEmail, *txtPassword, *txtConfPass, *txtKg, *txtCm, *txtAge;
@property NSMutableArray *arrayOfViews;
@property UIPageControl *page;
@property BOOL keyboardUp;
@end
