//
//  InstagramShareVC.m
//  Stamina
//
//  Created by João Lucas Sisanoski on 12/09/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import "InstagramShareVC.h"

@interface InstagramShareVC ()

@end

@implementation InstagramShareVC

- (IBAction)cameraAction:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:(id)self];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)cameraRollAction:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:(id)self];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)shareInstagram
{
    UIImage *screenShot = self.imageView.image;
    NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.ig"];
    [UIImagePNGRepresentation(screenShot) writeToFile:savePath atomically:YES];
    
    CGRect rect = CGRectMake(0 ,0 , 0, 0);
    NSString  *jpgPath = [NSHomeDirectory()     stringByAppendingPathComponent:@"Documents/Test.ig"];
    NSURL *igImageHookFile = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"file://%@", jpgPath]];
    self.dic.UTI = @"com.instagram.photo";
    self.dic = [self setupControllerWithURL:igImageHookFile usingDelegate:self];
    self.dic=[UIDocumentInteractionController interactionControllerWithURL:igImageHookFile];
    [self.dic presentOpenInMenuFromRect: rect    inView: self.view animated: YES ];
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://media?id=MEDIA_ID"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
        [self.dic presentOpenInMenuFromRect: rect    inView: self.view animated: YES ];
    }
    else
    {
        NSLog(@"No Instagram Found");
    }
}

#pragma Documents Delegate

- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate
{
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    return interactionController;
}

#pragma Image Picker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    [self.imageView setImage:chosenImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self performSelector:@selector(shareInstagram) withObject:self afterDelay:1.0f];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}



@end
