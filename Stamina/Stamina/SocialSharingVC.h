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
#import <QuartzCore/QuartzCore.h>
#import "AVCamPreviewView.h"
#import "SharingResponse.h"
#import "AppDelegate.h"
#import "MenuVC.h"

@interface SocialSharingVC : MenuVC  <UIDocumentInteractionControllerDelegate>

@property (weak, nonatomic) IBOutlet AVCamPreviewView *cameraView;
@property (nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property AVCaptureSession *session;

@property (weak, nonatomic) IBOutlet UIButton *pictureButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;

@property UIImage *userPicture;
//@property UIImageView *darkenView;
@property UIView *shareView;

@property BOOL hasPicture;
@property BOOL isOnShareMenu;
@property BOOL usingFrontCamera;



@end
