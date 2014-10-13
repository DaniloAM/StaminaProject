//
//  SharingResponse.h
//  Stamina
//
//  Created by Danilo Augusto Mative on 08/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface SharingResponse : NSObject <UIDocumentInteractionControllerDelegate>

@property (nonatomic, retain) UIDocumentInteractionController *dic;

-(void)sharePictureOnInstagram : (UIImage *)image;
+(void)sharePictureOnFacebook: (UIImage *)image;

@end
