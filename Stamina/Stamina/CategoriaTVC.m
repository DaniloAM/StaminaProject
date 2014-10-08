//
//  CategoriaTVC.m
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 07/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CategoriaTVC.h"

@interface CategoriaTVC ()

@end

@implementation CategoriaTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self table].delegate=self;
    self.table.dataSource=self;
    
    [self.table setContentOffset:self.table.contentOffset animated:NO];

    [self setArrayOfCat:[NSArray arrayWithObjects:@"    Categoria 1",@"    Categoria 2",@"    Categoria 3",@"    Categoria 4",@"    Categoria 5",@"    Categoria 6", nil]];

    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGRect temp = [self table].frame;
    temp.size.height = [[self arrayOfCat] count]*57 + [[self arrayOfCat] count]*1;
    [[self table] setFrame:temp];
    [[self table] setContentSize:CGSizeMake(self.table.frame.size.width, temp.size.height)];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self arrayOfCat] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = [[self arrayOfCat] objectAtIndex:indexPath.row ];
    static NSString *simpleTableIdentifier;
    
    simpleTableIdentifier = string;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = string;
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}

@end
