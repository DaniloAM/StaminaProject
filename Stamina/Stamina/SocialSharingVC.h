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
#import <Social/Social.h>
#import "AVCamPreviewView.h"
#import "SharingResponse.h"
#import "AppDelegate.h"

@interface SocialSharingVC : UIViewController <UIDocumentInteractionControllerDelegate>


@property (weak, nonatomic) IBOutlet AVCamPreviewView *cameraView;
@property (nonatomic, retain) UIDocumentInteractionController *dic;

@property (nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (weak, nonatomic) IBOutlet UIButton *pictureButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;

@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *instagramButton;
@property (weak, nonatomic) IBOutlet UIImageView *sharingImageView;


@property BOOL isOnShareMenu;

@property UIImage *userPicture;
@property UIImageView *darkenView;
@property UIImageView *imageView;

@property BOOL hasPicture;
@property BOOL usingFrontCamera;

@property AVCaptureSession *session;

@end
