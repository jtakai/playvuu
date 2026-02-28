//
//  AccountInfoYourNameCell.m
//  playvuu
//
//  Created by Marcela Nievas on 8/21/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "AccountInfoYourNameCell.h"
#import "PVTableConstants.h"
#import <Parse/Parse.h>

@interface AccountInfoYourNameCell ()

@property (weak, nonatomic) IBOutlet PFImageView * profilePicture;
@property (nonatomic, weak) IBOutlet UILabel * labelDisplayName;
@property (nonatomic, weak) IBOutlet UILabel * labelEmail;

@end

@implementation AccountInfoYourNameCell

@synthesize profilePicture, labelDisplayName, labelEmail;

-(void)reload
{
    [super reload];

    if (self.metadata && self.data)
    {
        labelDisplayName.text = [self.data objectForKey:[self.metadata objectForKey:kMetadataOutputFieldName]];
        labelEmail.text = [self.data objectForKey:[self.metadata objectForKey:kMetadataOutputFieldEmail]];
        PFFile *profilePictureFile = [self.data objectForKey:[self.metadata objectForKey:kMetadataOutputFieldProfilePicture]];
        
        if([profilePictureFile isKindOfClass: [PFFile class]]){
            [self.profilePicture setFile:profilePictureFile];
            [self.profilePicture loadInBackground];
        }
    }
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(profilePictureTapped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [profilePicture addGestureRecognizer:singleTap];
    [profilePicture setUserInteractionEnabled:YES];
}

- (void)profilePictureTapped:(UIGestureRecognizer *)gestureRecognizer
{    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
#if TARGET_IPHONE_SIMULATOR
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    
    [self.delegate presentImagePickerController:picker];
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.delegate cellBeingSelected:self];
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profilePicture.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];

    NSData *imageData =  UIImagePNGRepresentation(chosenImage);
    PFFile *pictureFile = [PFFile fileWithName:@"temp_profile.png" data:imageData];
    
    //This creates an orphan!
    self.profilePicture.file = pictureFile;
    
    NSString * outputField = [self.metadata objectForKey:kMetadataOutputFieldProfilePicture];
    [self.data setObject:pictureFile forKey:outputField];
    
    [self.delegate dataUpdated];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
