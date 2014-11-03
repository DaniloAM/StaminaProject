//
//  CadastroVC.m
//  Stamina
//
//  Created by João Lucas Sisanoski on 03/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CadastroVC.h"

@interface CadastroVC ()

@end

@implementation CadastroVC

- (void)viewDidLoad {
    [super viewDidLoad];

    _numberOfViews = 7;
    [self setPage:[[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 200)]];
    [[self page] setNumberOfPages:_numberOfViews];
    CGSize size = [[UIScreen mainScreen] bounds].size;
    [self setScroll:[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)]];
    [[self scroll] setContentSize:CGSizeMake(_numberOfViews*size.width, 0)];
    _scroll.delegate = self;
    [self.view addSubview:[self scroll]];
    _currentIndex = 0;
    [self createBackgroundColor];
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator =NO;
    [self.view addSubview:_page];
    _scroll.delegate = self;
     [self loadTxt];
    [self createBackgroundColor];
    [self registerForKeyboardNotifications];
}

-(void)loadTxt{
    CGSize size = [[UIScreen mainScreen] bounds].size;

    [self setTxtName:[[UITextField alloc] initWithFrame:CGRectMake(65*size.width/640, 605*size.height/1136, 510*size.width/640, 73*size.height/1136)]];
    [self setTxtEmail:[[UITextField alloc] initWithFrame:CGRectMake(65*size.width/640, 605*size.height/1136, 510*size.width/640, 73*size.height/1136)]];
    [self setTxtPassword:[[UITextField alloc] initWithFrame:CGRectMake(65*size.width/640, 605*size.height/1136, 510*size.width/640, 73*size.height/1136)]];
    [self setTxtNick:[[UITextField alloc] initWithFrame:CGRectMake(65*size.width/640, 719*size.height/1136, 510*size.width/640, 73*size.height/1136)]];
    [self setTxtConfPass:[[UITextField alloc] initWithFrame:CGRectMake(65*size.width/640, 719*size.height/1136, 510*size.width/640, 73*size.height/1136)]];
    [self setTxtConfEmail:[[UITextField alloc] initWithFrame:CGRectMake(65*size.width/640, 719*size.height/1136, 510*size.width/640, 73*size.height/1136)]];
    [self setTxtKg:[[UITextField alloc] initWithFrame:CGRectMake(250*size.width/640, 719*size.height/1136, 141*size.width/640, 73*size.height/1136)]];
    [self setTxtCm:[[UITextField alloc] initWithFrame:CGRectMake(250*size.width/640, 719*size.height/1136, 141*size.width/640, 73*size.height/1136)]];
    [self setTxtAge:[[UITextField alloc] initWithFrame:CGRectMake(250*size.width/640, 719*size.height/1136, 141*size.width/640, 73*size.height/1136)]];
    _arrayOfViews = [NSMutableArray arrayWithObjects:_txtAge,_txtCm,_txtConfEmail,_txtConfPass,_txtEmail,_txtKg,_txtName,_txtNick,_txtPassword, nil];
    for(int x = 0 ; x < [[self arrayOfViews] count];x++){
        UITextField *view = [[self arrayOfViews] objectAtIndex:x];
        [view setBackgroundColor:[UIColor whiteColor]];
        view.layer.cornerRadius = 7;
        view.textAlignment = NSTextAlignmentCenter;
        [view setFont:[UIFont fontWithName:@"Avenir" size:18]];
        view.delegate = self;
    }

    
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _lastContentOffset = scrollView.contentOffset.x;
    [self.view endEditing:YES];

}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self checkWhichPosition:scrollView.contentOffset.x];
}
-(void)left{
    NSLog(@"left");
    _currentIndex++;
    [self callNextPageIndex:_currentIndex];
}
-(void)right{
    NSLog(@"right");
    
    _currentIndex--;
    [self callNextPageIndex:_currentIndex];
}
-(void)checkWhichPosition:(float)x{
    if(x>_lastContentOffset)
        [self left];
    else
        [self right];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(!decelerate){
        [self checkWhichPosition:scrollView.contentOffset.x];
    }
}
-(void)createBackgroundColor{
    CGSize size = [[UIScreen mainScreen] bounds].size;

    
    for(int x = 0 ; x < _numberOfViews;x++){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(65*size.width/640, 605*size.height/1136, 510*size.width/640, 73*size.height/1136)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont fontWithName:@"Avenir" size:22]];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x*size.width, 0, size.width, size.height)];
        [self.scroll addSubview:view];
        switch (x) {
            case 1:
                [view addSubview:[self txtEmail]];
                [[self txtEmail] setPlaceholder:@"Email"];
                [view addSubview:[self txtConfEmail]];
                [[self txtConfEmail] setPlaceholder:@"Confirme o email"];
                
                break;
            case 2:
                [view addSubview:[self txtPassword]];
                [[self txtPassword] setPlaceholder:@"Senha"];

                [view addSubview:[self txtConfPass]];
                [[self txtConfPass] setPlaceholder:@"Confirme a senha"];

                
                break;
            case 3:
                [label setText:@"Peso:"];
                [view addSubview:label];
                [view addSubview:[self txtKg]];
                [[self txtKg] setPlaceholder:@"Kg"];

                
                break;
            case 4:
                [label setText:@"Altura:"];
                [view addSubview:label];
                [view addSubview:[self txtCm]];
                [[self txtCm] setPlaceholder:@"Cm"];

                
                break;
            case 5:
                [label setText:@"Idade:"];
                [view addSubview:label];
                [view addSubview:[self txtAge]];
                [[self txtAge] setPlaceholder:@"Cm"];

                
                break;
            case 6:
                
                break;
            case 0:
                [view addSubview:[self txtName]];
                [[self txtName] setPlaceholder:@"Nome"];

                [view addSubview:[self txtNick]];
                [[self txtNick] setPlaceholder:@"Nickname"];

                

                break;
                
            default:
                break;
        }
        
    }
        
}

-(void)callNextPageIndex : (int )x{
    if(x == _numberOfViews)
        _currentIndex--;
    if(x <0)
        _currentIndex = 0;
    if(x == _numberOfViews|| x < 0)
        return;
    NSLog(@"%d",x);
    
    [UIView animateWithDuration:0.4
                     animations:^{
                        _page.currentPage = x;
                     }];
    CGPoint p = CGPointMake(x*_scroll.frame.size.width, 0);
    [_scroll setContentOffset:p animated:YES];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
-(void)moveView: (UIView *)bigView withPoint: (CGPoint )point withDuration: (float)duration{
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:duration];
    bigView.frame = CGRectMake(point.x, point.y, bigView.frame.size.width, bigView.frame.size.height);
    [UIView commitAnimations];
}
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGSize keyboardSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight ) {
        CGSize origKeySize = keyboardSize;
        keyboardSize.height = origKeySize.width;
        keyboardSize.width = origKeySize.height;
    }
    [self moveView:_scroll withPoint:CGPointMake(0,-keyboardSize.height/2) withDuration:[self keyboardAnimationDurationForNotification:aNotification ]];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGSize keyboardSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight ) {
        CGSize origKeySize = keyboardSize;
        keyboardSize.height = origKeySize.width;
        keyboardSize.width = origKeySize.height;
    }
    [self moveView:_scroll withPoint:CGPointMake(0,0) withDuration:[self keyboardAnimationDurationForNotification:aNotification ]];
    _keyboardUp = NO;

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_scroll endEditing:YES];
}
- (NSTimeInterval)keyboardAnimationDurationForNotification:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    NSValue* value = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval duration = 0;
    [value getValue:&duration];
    return duration;
}
@end
