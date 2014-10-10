//
//  CategoriaVC.m
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 10/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "CategoriaVC.h"

@interface CategoriaVC ()

@end

@implementation CategoriaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFrontal:[NSArray arrayWithObjects:@"Abdominal",@"Ante-Braço",@"Bíceps",@"Peitoral",@"Quadríceps",@"Ombros",@"Trapézio",@"Tríceps", nil]];
    [self setTraseiro:[NSArray arrayWithObjects:@"Ante-Braço",@"Bíceps",@"Dorsal",@"Glúteos",@"Lombar",@"Ombros",@"Panturrilha",@"Posterior de Coxa", @"Rombóides",@"Trapézio",@"Tríceps",nil]];
    self.table.delegate = self;
    self.table.dataSource=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return [[self frontal] count];
    }
    
    return [[self traseiro] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
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

@end
