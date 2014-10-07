//
//  SocialSharingVC.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 01/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <AVFoundation/AVFoundation.h>
#import "AVCamPreviewView.h"

@interface SocialSharingVC : UIViewController <UIDocumentInteractionControllerDelegate>


@property (weak, nonatomic) IBOutlet AVCamPreviewView *cameraView;
@property (nonatomic, retain) UIDocumentInteractionController *dic;

@property (nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (weak, nonatomic) IBOutlet UIButton *pictureButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;

@property UIButton *fbBtn;
@property UIButton *instaBtn;
@property UIButton *cancelBtn;
@property UIImageView *shareLogo;

@property BOOL isOnShareMenu;

@property UIImage *userPicture;
@property UIImageView *darkenView;
@property UIImageView *imageView;

@property BOOL hasPicture;
@property BOOL usingFrontCamera;

@property AVCaptureSession *session;

@end
