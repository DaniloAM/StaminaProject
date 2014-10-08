//
//  CategoriaTVC.h
//  Stamina
//
//  Created by JOAO LUCAS BISCAIA SISANOSKI on 07/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriaTVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property NSArray *arrayOfCat;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@end
