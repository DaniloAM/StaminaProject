//
//  InstagramShareVC.h
//  Stamina
//
//  Created by João Lucas Sisanoski on 12/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstagramShareVC : UIViewController <UIImagePickerControllerDelegate, UIDocumentInteractionControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) UIDocumentInteractionController *dic;
@end
