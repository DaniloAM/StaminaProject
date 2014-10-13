//
//  SharingResponse.m
//  Stamina
//
//  Created by Danilo Augusto Mative on 08/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "SharingResponse.h"

@implementation SharingResponse

+(void)sharePictureOnFacebook: (UIImage *)image {
    
    if([FBDialogs canPresentShareDialogWithPhotos]) {
        
        NSLog(@"canPresent");
        
        
        FBPhotoParams *params = [[FBPhotoParams alloc] init];
        params.photos = @[image];
        
        
        [FBDialogs presentShareDialogWithPhotoParams:params
                                         clientState:nil
                                             handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                 if (error) {
                                                     NSLog(@"Error: %@", error.description);
                                                 } else {
                                                     NSLog(@"Success!");
                                                 }
                                             }];
        
    }
    
    else {
        //The user doesn't have the Facebook for iOS app installed, so we can't present the Share Dialog
        
    }
    
}

-(void)sharePictureOnInstagram : (UIImage *)image {
    
//    NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.ig"];
//    [UIImagePNGRepresentation(image) writeToFile:savePath atomically:YES];
//    
//    CGRect rect = CGRectMake(0 ,0 , 0, 0);
//    NSString  *jpgPath = [NSHomeDirectory()     stringByAppendingPathComponent:@"Documents/Test.ig"];
//    NSURL *igImageHookFile = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"file://%@", jpgPath]];
//    self.dic.UTI = @"com.instagram.photo";
//    self.dic = [self setupControllerWithURL:igImageHookFile usingDelegate:self];
//    self.dic=[UIDocumentInteractionController interactionControllerWithURL:igImageHookFile];
//    [self.dic presentOpenInMenuFromRect: rect    inView: self.view animated: YES ];
//    NSURL *instagramURL = [NSURL URLWithString:@"instagram://media?id=MEDIA_ID"];
//    if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
//    {
//        [self.dic presentOpenInMenuFromRect: rect    inView: self.view animated: YES ];
//    }
//    else
//    {
//        NSLog(@"No Instagram Found");
//    }
//    
    
}

-(UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate {
    
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    return interactionController;
    
}

@end
