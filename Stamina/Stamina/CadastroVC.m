//
//  ViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "CadastroVC.h"

@interface CadastroVC ()

@end

@implementation CadastroVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Create the data model
    _pageTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"Free Regular Update"];
    _pageImages = @[@"page1.png", @"page2.png", @"page3.png", @"page4.png"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    CadastroPVC *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

}
-(IBAction)voltar{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CadastroPVC *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    CadastroPVC *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    CadastroPVC *cadastro = ((CadastroPVC*) viewController);

    NSUInteger index = cadastro.pageIndex;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
    
}
-(BOOL )check : (CadastroPVC *)cadastro{
    Cadastro *cada = [Cadastro alloc];
    NSUInteger index =  cadastro.pageIndex;

    switch (index) {
        case 0:

            if([[[cadastro txtField1] text] isEqualToString:@""]||[[cadastro txtField1] text].length<=0){
                return 0;
                
            }
            if([[[cadastro txtField2] text] isEqualToString:@""]||[[cadastro txtField2] text].length<=0){
                return 0;
            }
            
            
            
            
            [cada setNome:[[cadastro txtField1] text]];
            [cada setNick:[[cadastro txtField2] text]];
            
            break;
        case 1:
            if([[[cadastro txtField1] text] isEqualToString:@""]||[[cadastro txtField1] text].length<=0){
                return 0;
            }
            if([[[cadastro txtField2] text] isEqualToString:@""]||[[cadastro txtField2] text].length<=0){
                return 0;
            }
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
            
        default:
            break;
    }
    return 1;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    CadastroPVC *cadastro = ((CadastroPVC*) viewController);
    NSUInteger index = cadastro.pageIndex;
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        NSLog(@"deveria checar aqui");
        return nil;
    }
    return [self viewControllerAtIndex:index];
 
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
@end
