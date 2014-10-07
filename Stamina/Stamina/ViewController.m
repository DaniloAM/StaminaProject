//
//  ViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _bar.pageIndicatorTintColor = [UIColor whiteColor];
    _bar.currentPageIndicatorTintColor = [UIColor blackColor];
    _bar.backgroundColor = [UIColor clearColor];
    // Create the data model
    if(!_pageTitles)
    _pageTitles = @[@"Nome", @"Email", @"Senha", @"Informações Físicas", @"Informações Físicas", @"Informações Físicas", @"Informações Físicas", @"Informações Físicas"];

    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-150);

    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

}
-(void)presentError: (int) error : (NSString *)strError{

    ErrorVC *vc = [[ErrorVC alloc] initWithNibName:nil bundle:nil];
    RWBlurPopover *popover = [[RWBlurPopover alloc] initWithContentViewController:vc];
    [vc setError:error];
    [vc setStringError:strError];
    [self presentViewController:popover animated:YES completion:nil];
    
}
- (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}
-(IBAction)avanca{
 Cadastro *cd = [Cadastro alloc];
    
    if(_index>5)
    {
        
        if ([self connected]) {
            
       
        if([cd nome]==nil){
            [self presentViewAtIndex:0];
            [self presentError:0 :@"Nome inválido"];
            return;
        }
        if([cd nick]==nil){
            [self presentViewAtIndex:0];
            [self presentError:0 :@"Nick invalido"];
            return;
        }
        if([cd email]==nil||![self validateEmail:[cd email]]){
            [self presentViewAtIndex:1];
        [self presentError:0 :@"Cheque o email"];
            return;
        }
        if ([cd senha]==nil) {
                        [self presentViewAtIndex:2];
            [self presentError:0 :@"Cheque a senha"];
            return;
        }
      
        if([cd peso]==0){
            [self presentError:0 :@"Peso inválido"];
            return;

        }
        if([cd altura]==0){
                        [self presentViewAtIndex:3];
            [self presentError:0 :@"Altura inválida"];
            return;
        }
        if([cd idade]==0){
                        [self presentViewAtIndex:4];
            [self presentError:0 :@"Idade inválida"];
            
            return;
        }
            [self presentViewAtIndex:7];
            return;
    }
       
    }
   
    _index++;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:_index];
    NSArray *viewControllers = @[startingViewController];
    [self bar].currentPage = _index;
       [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}
-(void)presentViewAtIndex: (int )index{
    PageContentViewController *startingViewController = [self viewControllerAtIndex:index];
    NSArray *viewControllers = @[startingViewController];
    [self bar].currentPage = index;
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    _index=index;
}

-(IBAction)login{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}


- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{

    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;

    
    return pageContentViewController;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    Cadastro *cd = [Cadastro alloc];
    if([cd stringResposta]){
        if ([[cd stringResposta]isEqualToString:@"Adicionado"]||[[cd stringResposta]isEqualToString:@"1"]) {
            UserData *usr = [UserData alloc];
            [usr setName:[cd nome]];
            [usr setEmail:[cd email]];
            [usr setPassword:[cd senha]];
            [usr setInitialWeight:[cd peso]];
            [usr setHeightInCentimeters:[cd altura]];
            [usr setAge:[cd idade]];
            [usr setSex:[cd sexo]];
            [usr setNickName:[cd nick]];
            [cd setEmail:nil];
            [cd setStringResposta:nil];
            [cd setSenha:nil];
            [cd setNick:nil];
            [cd setNome:nil];
            [cd setAltura:0];
            [cd setIdade:0];
            [cd setPeso:0];
            
            [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            [self presentError:0 :[cd stringResposta]];
            [cd setStringResposta:nil];

        }
    }
    if(_index!=0)
    [self presentViewAtIndex:0];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma mark - Page View Controller Data Source
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index--];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    if (index == NSNotFound) {
        return nil;
    }

    if (index == [self.pageTitles count]) {
        return nil;
    }
    index++;
    return [self viewControllerAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    PageContentViewController *vc = [pageViewController.viewControllers lastObject];
    _index = (int)vc.pageIndex;
    [self bar].currentPage = vc.pageIndex;
}
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end
