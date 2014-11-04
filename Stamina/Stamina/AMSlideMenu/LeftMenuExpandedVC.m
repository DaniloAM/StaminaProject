//
//  LeftMenuExpandedVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 03/11/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "LeftMenuExpandedVC.h"


#define LMenu1 @"Stamina"
    #define M1Sub1 @"Início"
    #define M1Sub2 @"Calendario"
    #define M1Sub3 @"Trajetos"
    #define M1Sub4 @"Exercícios"


#define LMenu2 @"Compartilhar"
    #define M2Sub1 @"Resultado"
    #define M2Sub2 @"Foto agora"
    #define M2Sub3 @"Foto da galeria"


#define LMenu3 @"Desafiar"
    #define M3Sub1 @"Criar desafio"
    #define M3Sub2 @"Exercício realizado"


#define LMenu4 @"Resultados"
    #define M4Sub1 @"Físicos"
    #define M4Sub2 @"Pontuação"
    #define M4Sub3 @"Premiações"


#define LMenu5 @"Configurações"




@interface LeftMenuExpandedVC ()



@end

@implementation LeftMenuExpandedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setTableViewBackgroundColor:[UIColor staminaBlackColor]];
    [super setRowTextColor:[UIColor staminaYellowColor]];
    
    [self setLeftMenuTableView:[super tableView]];
    [[self leftMenuTableView] setFrame:self.view.frame];
    
    [[self leftMenuTableView] setDelegate:self];
    [[self leftMenuTableView] setDataSource:self];
    
    [self addMenuTitles];
    [super reloadTableViewColors];
    
    [[self leftMenuTableView] reloadData];
    
    [self.view addSubview:[self leftMenuTableView]];
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    [super closeExpandedRow];
}


-(void)addMenuTitles {
    
    [[super titlesArray] addObject:LMenu1];
    [[super titlesArray] addObject:LMenu2];
    [[super titlesArray] addObject:LMenu3];
    [[super titlesArray] addObject:LMenu4];
    [[super titlesArray] addObject:LMenu5];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    
    switch ([self menuRowForTitle:[super openTitle]]) {
        case 1:
            [self openStaminaCategory];
            break;
        case 2:
            [self openShareCategory];
            break;
        case 3:
            [self openChallengeCategory];
            break;
        case 4:
            [self openResultsCategory];
            break;
        case 5:
            [self openConfigurationsCategory];
            break;
        default:
            break;
    }
    
    [[self leftMenuTableView] reloadData];
    
}


-(NSInteger)menuRowForTitle:(NSString *)str {
    
    if([str isEqualToString:LMenu1]) {
        return 1;
    }
    
    if([str isEqualToString:LMenu2]) {
        return 2;
    }
    
    if([str isEqualToString:LMenu3]) {
        return 3;
    }
    
    if([str isEqualToString:LMenu4]) {
        return 4;
    }
    
    if([str isEqualToString:LMenu5]) {
        return 5;
    }
    
    return -1;
    
}


-(void)openStaminaCategory {
    NSInteger subCategories = 4;
    [super setExpandHeight:tableViewRowHeight * (subCategories + 2)];
    
    [self prepareSubcategoriesWithStrings:@[M1Sub1, M1Sub2, M1Sub3, M1Sub4]];
    
}

-(void)openShareCategory {
    NSInteger subCategories = 3;
    [super setExpandHeight:tableViewRowHeight * (subCategories + 2)];
    
    [self prepareSubcategoriesWithStrings:@[M2Sub1, M2Sub2, M2Sub3]];
    
}

-(void)openChallengeCategory {
    NSInteger subCategories = 2;
    [super setExpandHeight:tableViewRowHeight * (subCategories + 2)];
    
    [self prepareSubcategoriesWithStrings:@[M3Sub1, M3Sub2]];

    
}

-(void)openResultsCategory {
    NSInteger subCategories = 3;
    [super setExpandHeight:tableViewRowHeight * (subCategories + 2)];
    
    [self prepareSubcategoriesWithStrings:@[M4Sub1, M4Sub2, M4Sub3]];
     
}

-(void)openConfigurationsCategory {
    
}


-(void)prepareSubcategoriesWithStrings: (NSArray *)array {
    
    [[super cellContentsArray] removeAllObjects];
    
    CGRect categoryFrame = CGRectMake(30, tableViewRowHeight, self.view.frame.size.width, tableViewRowHeight);
    
    
    for(NSInteger row = 0; row < [array count]; row++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:categoryFrame];

        button.titleLabel.text = [array objectAtIndex:row];
        [button titleLabel].font = [UIFont fontWithName:@"Avenir" size:22.0];
        [button setTitle:[array objectAtIndex:row] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor staminaYellowColor] forState:UIControlStateNormal];
        
        [button titleLabel].textAlignment = NSTextAlignmentCenter;
        
        
        NSLog(@"%@", button.titleLabel.text);
        
        [button addTarget:self action:@selector(goToViewNamed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [[super cellContentsArray] addObject:button];
        categoryFrame.origin.y += tableViewRowHeight;
        
    }
    
    [[self leftMenuTableView] reloadData];
    
}


-(void)goToViewNamed: (UIButton *)sender {
    
    NSString *str = sender.titleLabel.text;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    UINavigationController *navigation = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"Go"];
                              
    [self presentViewController:navigation animated:true completion:NULL];

    //[navigation popToViewController:<#(UIViewController *)#> animated:<#(BOOL)#>]
    
}



@end
