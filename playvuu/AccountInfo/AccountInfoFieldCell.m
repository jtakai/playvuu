//
//  AccountInfoFieldCell.m
//  playvuu
//
//  Created by Marcela Nievas on 8/23/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "AccountInfoFieldCell.h"
#import "PVTableConstants.h"

@interface AccountInfoFieldCell ()

@property (nonatomic, weak) IBOutlet UILabel * fieldTitle;
@property (nonatomic, weak) IBOutlet UITextField * fieldInput;

@end

@implementation AccountInfoFieldCell

@synthesize fieldInput, fieldTitle;

-(void)reload
{
    [super reload];
        
    if (self.metadata)
    {
        fieldTitle.text = [self.metadata objectForKey:kMetadataFieldTitle];
        fieldInput.placeholder = [self.metadata objectForKey:kMetadataFieldPlaceHolder];
        fieldInput.delegate = self;
        self.first = fieldInput;
        
        fieldInput.text = @"";
        if (self.data)
        {
            NSString * outputField = [self.metadata objectForKey:kMetadataOutputField];
            fieldInput.text = [self.data objectForKey:outputField];
        }
    }
}

-(void)endEditing
{
    [fieldInput endEditing:YES];
}

-(BOOL)validateEmail:(NSString*)email
{
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.delegate cellBeingSelected:self];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    BOOL ret = YES;
    
    NSString * validationType = [self.metadata objectForKey:kMetadataFieldValidationType];
    if (validationType)
    {
        if ([validationType isEqualToString:kFieldValidationEmail])
        {
            ret = ([textField.text length] == 0) || [self validateEmail:textField.text];
            if (!ret)
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:@"Please enter a valid Email."
                                                               delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                [alert show];
            }
        }
    }
    
    return ret;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString * outputField = [self.metadata objectForKey:kMetadataOutputField];
    [self.data setObject:textField.text     forKey:outputField];
    
    [self.delegate dataUpdated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.delegate goNextCell:self];
    return YES;
}

@end
