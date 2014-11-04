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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self titlesArray] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    //Standard cell properties
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    //If the cell that is loading is the expanded one
    if(indexPath.row == _openRowIndex) {
        
        [self addContentToCell:cell];
        
    }
    
    
    //Else loads the title of the other routes
    else {
        
        cell.textLabel.text = [[self titlesArray] objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:20.0];
        cell.textLabel.textColor = _rowTextColor;
        
    }
    
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == _openRowIndex) {
        
        if(_expandHeight > tableViewRowHeight)
            return _expandHeight;
        
    }
    
    return tableViewRowHeight;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch ([self menuRowForTitle:[self openTitle]]) {
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
    
    [[self tableView] reloadData];

    if(indexPath.row == _openRowIndex) {
        return;
    }
    
    _openTitle = [[self titlesArray] objectAtIndex:indexPath.row];
    _openRowIndex = indexPath.row;
    
    NSArray *cellArray;
    
    if([self openIndexPath]) {
        cellArray = @[[self openIndexPath], indexPath];
    }
    
    else cellArray = @[indexPath];
    
    
    [[self tableView] reloadRowsAtIndexPaths:cellArray withRowAnimation:UITableViewRowAnimationFade];
    [[self tableView] scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
    
    [self setOpenIndexPath:indexPath];
    
}


-(UITableViewCell *)getOpenCell {
    
    return [[self tableView] cellForRowAtIndexPath:_openIndexPath];
    
}



-(void)addContentToCell: (UITableViewCell *)cell {
    
    //Add content
    for(int x = 0; x < [[self cellContentsArray] count]; x++) {
        
        [cell addSubview:[[self cellContentsArray] objectAtIndex:x]];
        
    }
    
    
    //Title of cell
    CGRect titleFrame = CGRectMake(0, 0, [self tableView].frame.size.width, tableViewRowHeight);
    UILabel *title = [UILabel staminaLabelWithFrame:titleFrame fontSize:22.0 color:[UIColor staminaYellowColor]];
    
    [title setText:[[self titlesArray] objectAtIndex:_openRowIndex]];
    [title setBackgroundColor:[UIColor staminaBlackColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    
    
    
    //Closing gesture
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeExpandedRow)];
    [doubleTap setNumberOfTapsRequired:2];
    
    
    //Add to cell
    [cell addGestureRecognizer:doubleTap];
    [cell addSubview:title];
    
}


-(void)closeExpandedRow {
    
    _openRowIndex = -1;
    
    if([self openIndexPath])
        [[self tableView] reloadRowsAtIndexPaths:@[_openIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    _openIndexPath = nil;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //Standard inits
    _expandHeight = 200;
    _openRowIndex = -1;
    _tableViewBackgroundColor = [UIColor staminaYellowColor];
    _rowFont = [UIFont fontWithName:@"Avenir" size:fontLabelSize];
    _rowTextColor = [UIColor staminaBlackColor];
    
    
    [self setTableView:[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)]];
    [[self tableView] setRowHeight:tableViewRowHeight];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    [self reloadTableViewColors];
    
    [self setTitlesArray:[NSMutableArray array]];
    [self setCellContentsArray:[NSMutableArray array]];
    [self setTableViewBackgroundColor:[UIColor staminaBlackColor]];
    [self setRowTextColor:[UIColor staminaYellowColor]];
    
    [[self tableView] setFrame:self.view.frame];

    
    [self addMenuTitles];
    
    [[self tableView] reloadData];
    
    [self.view addSubview:[self tableView]];
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self closeExpandedRow];
}


-(void)addMenuTitles {
    
    [[self titlesArray] addObject:LMenu1];
    [[self titlesArray] addObject:LMenu2];
    [[self titlesArray] addObject:LMenu3];
    [[self titlesArray] addObject:LMenu4];
    [[self titlesArray] addObject:LMenu5];
    
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
    [self setExpandHeight:tableViewRowHeight * (subCategories + 2)];
    
    [self prepareSubcategoriesWithStrings:@[M1Sub1, M1Sub2, M1Sub3, M1Sub4]];
    
}

-(void)openShareCategory {
    NSInteger subCategories = 3;
    [self setExpandHeight:tableViewRowHeight * (subCategories + 2)];
    
    [self prepareSubcategoriesWithStrings:@[M2Sub1, M2Sub2, M2Sub3]];
    
}

-(void)openChallengeCategory {
    NSInteger subCategories = 2;
    [self setExpandHeight:tableViewRowHeight * (subCategories + 2)];
    
    [self prepareSubcategoriesWithStrings:@[M3Sub1, M3Sub2]];

    
}

-(void)openResultsCategory {
    NSInteger subCategories = 3;
    [self setExpandHeight:tableViewRowHeight * (subCategories + 2)];
    
    [self prepareSubcategoriesWithStrings:@[M4Sub1, M4Sub2, M4Sub3]];
     
}

-(void)openConfigurationsCategory {
    
}


-(void)prepareSubcategoriesWithStrings: (NSArray *)array {
    
    [[self cellContentsArray] removeAllObjects];
    
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
        
        
        [[self cellContentsArray] addObject:button];
        categoryFrame.origin.y += tableViewRowHeight;
        
    }
    
    [[self tableView] reloadData];
    
}
-(void)reloadTableViewColors {
    
    [[self tableView] setBackgroundColor:_tableViewBackgroundColor];
    [[self tableView] setSeparatorColor:[UIColor staminaBlackColor]];
    
}


-(void)goToViewNamed: (UIButton *)sender {
    
    NSString *str = sender.titleLabel.text;
    
    if([str isEqualToString:M1Sub1]){
        
    }
    else  if([str isEqualToString:M1Sub2]){
        
    }
    else  if([str isEqualToString:M1Sub3]){
        
    }
    else  if([str isEqualToString:M1Sub4]){
        
    }
    else  if([str isEqualToString:M2Sub1]){
        
    }
    else  if([str isEqualToString:M2Sub2]){
        
    }
    else  if([str isEqualToString:M2Sub3]){
        
    }
    else  if([str isEqualToString:M3Sub1]){
        
    }
    else  if([str isEqualToString:M3Sub2]){
        
    }
    else  if([str isEqualToString:M4Sub1]){
        
    }
    else  if([str isEqualToString:M4Sub2]){
        
    }
    else  if([str isEqualToString:M4Sub3]){
        
    }

   
    
    
}



@end
