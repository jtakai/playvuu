//
//  AccountInfoGenderCell.m
//  playvuu
//
//  Created by Marcela Nievas on 8/23/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "AccountInfoGenderCell.h"
#import "PVTableConstants.h"

@interface AccountInfoGenderCell ()
@property (weak, nonatomic) IBOutlet UISegmentedControl * genderSelector;
@end

@implementation AccountInfoGenderCell

@synthesize genderSelector;

-(void)reload
{
    [super reload];
    
    if (self.metadata && self.data)
    {
        NSString * outputField = [self.metadata objectForKey:kMetadataOutputField];
        NSString * gender = [self.data objectForKey:outputField];
        
        if (gender)
        {
            if ([gender isEqualToString:kMetadataGenderMale])
            {
                genderSelector.selectedSegmentIndex = 0; // Male
            }
            else
            {
                genderSelector.selectedSegmentIndex = 1;
            }
        }
        else
        {
            genderSelector.selectedSegmentIndex = 0; // Male
            [self.data setObject:kMetadataGenderMale forKey:outputField];
        }
        
        [genderSelector removeTarget:self
                              action:@selector(action:)
                    forControlEvents:UIControlEventValueChanged];
        
        [genderSelector addTarget:self
                             action:@selector(action:)
                   forControlEvents:UIControlEventValueChanged];
    }
}

-(void)action:(UISegmentedControl*)segment
{
    NSString * outputField = [self.metadata objectForKey:kMetadataOutputField];
    if ([segment selectedSegmentIndex] == 0) // Male
    {
        [self.data setObject:kMetadataGenderMale forKey:outputField];
    }
    else
    {
        [self.data setObject:kMetadataGenderFemale forKey:outputField];
    }
    
    [self.delegate dataUpdated];
}

@end
