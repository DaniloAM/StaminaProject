//
//  SocialSharingVC.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 01/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "SocialSharingVC.h"

@interface SocialSharingVC ()

@end

@implementation SocialSharingVC



- (void)viewDidLoad  {
    
    [super viewDidLoad];
    
    [self setDarkenView:[[UIImageView alloc]init]];
    [self setImageView:[[UIImageView alloc]init]];
    [[self darkenView] setFrame:self.view.frame];
    [[self imageView] setFrame:_cameraView.frame];
    [[self darkenView] setHidden:true];
    [[self imageView] setHidden:true];
    [[self facebookButton] setHidden:true];
    [[self instagramButton] setHidden:true];
    [[self sharingImageView] setHidden:true];
    
    [self.view addSubview:[self darkenView]];

    AVCaptureStillImageOutput *stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    [stillImageOutput setOutputSettings:@{AVVideoCodecKey : AVVideoCodecJPEG}];
    [self setStillImageOutput:stillImageOutput];
    
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetMedium;
    [_session addOutput:[self stillImageOutput]];
    
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    //----- SHOW LIVE CAMERA PREVIEW -----
    _usingFrontCamera = true;
    [self startCameraPreviewWithCamera:[self frontCamera]];
    
}



-(void)startCameraPreviewWithCamera: (AVCaptureDevice *)camera {
    
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    
    captureVideoPreviewLayer.frame = self.cameraView.bounds;
    [self.cameraView.layer addSublayer:captureVideoPreviewLayer];
    
    AVCaptureDevice *device = camera;
    
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        // Handle the error appropriately.
        NSLog(@"ERROR: trying to open camera: %@", error);
        
    }
    

    for(AVCaptureDeviceInput *inputFound in _session.inputs) {
        
        [_session removeInput:inputFound];
        
    }
    
    [_session addInput:input];
    [_session startRunning];
    
    [self.view addSubview:[self imageView]];
    
}

-(IBAction)changeCamera {
    
    AVCaptureDevice *device;
    
    if(_usingFrontCamera) {
        device = [self backCamera];
        _usingFrontCamera = false;
    } else {
        _usingFrontCamera = true;
        device = [self frontCamera];
    }
    
    [_session stopRunning];
    
    [self startCameraPreviewWithCamera:device];
    
}


-(AVCaptureDevice *)backCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionBack) {
            return device;
        }
    }
    return nil;
}


-(AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    return nil;
}



- (IBAction)snapStillImage:(id)sender  {

    if(_isOnShareMenu) {
        return;
    }
    
    if(![[self imageView] isHidden]) {
        [self presentShareMenu];
        return;
    }
    
    //Perfom these selectors with delays to remove any noises from still images
    [self performSelector:@selector(takePicture) withObject:nil afterDelay:0.2];
    [self performSelector:@selector(takePicture) withObject:nil afterDelay:0.3];
    [self performSelector:@selector(changeImageView) withObject:nil afterDelay:0.4];
    
}


-(void)returnToCamera {
    
    [[self facebookButton] setHidden:true];
    [[self instagramButton] setHidden:true];
    [[self sharingImageView] setHidden:true];
    
    _isOnShareMenu = false;
    
    [[self imageView] setHidden:true];
    [[self darkenView] setHidden:true];
    
    [[self pictureButton] setTitle:@"Take" forState:UIControlStateNormal];
    
}


-(void)changeImageView {
    
    [[self imageView] setImage:_userPicture];
    [[self imageView] setHidden:false];
    
    [[self pictureButton] setTitle:@"Share" forState:UIControlStateNormal];

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self returnToCamera];
    
}


-(void)takePicture {
    
    // Capture a still image.
    [[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:[[self stillImageOutput] connectionWithMediaType:AVMediaTypeVideo] completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
        if (imageDataSampleBuffer)
        {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            
            _userPicture = [[UIImage alloc] initWithData:imageData];
            
            if(_usingFrontCamera) {
                _userPicture = [UIImage imageWithCGImage:_userPicture.CGImage
                                               scale:_userPicture.scale orientation: UIImageOrientationLeftMirrored];
            }
            
        }
    }];
    
}


-(void)presentShareMenu {
    
    _isOnShareMenu = true;
    
    [self.view bringSubviewToFront:[self darkenView]];
    [self.view bringSubviewToFront:[self facebookButton]];
    [self.view bringSubviewToFront:[self instagramButton]];
    [self.view bringSubviewToFront:[self sharingImageView]];

    
    [[self darkenView] setHidden:false];
    [[self darkenView] setImage:[self darkenImageOfScreen]];
    
    [[self facebookButton] setHidden:false];
    [[self instagramButton] setHidden:false];
    [[self sharingImageView] setHidden:false];
    
}


- (UIImage *)screenSnapshot {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



- (UIImage *)darkenImageOfScreen {
    
    UIImage *image = [self screenSnapshot];
    UIColor *color = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -area.size.height);
    
    CGContextSaveGState(context);
    CGContextClipToMask(context, area, image.CGImage);
    
    [color set];
    CGContextFillRect(context, area);
    
    CGContextRestoreGState(context);
    
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    
    CGContextDrawImage(context, area, image.CGImage);
    
    UIImage *darkenImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return darkenImage;
}



-(IBAction)sharePictureOnFacebook {
    
    [SharingResponse sharePictureOnFacebook:_userPicture];
    
    [self returnToCamera];
    
}

-(IBAction)sharePictureOnInstagram {
    
    [SharingResponse sharePictureOnInstagram:_userPicture];
    
    [self returnToCamera];
    
}



@end
