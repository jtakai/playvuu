//
//  PVTableConstants.h
//  playvuu
//
//  Created by Marcela Nievas on 8/21/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//



extern NSString* const kCellId;
extern NSString* const kCellHeight;
extern NSString* const kCellMetadata;
extern NSString* const kCellCallbackKey;

extern NSString* const kMetadataFieldTitle;
extern NSString* const kMetadataFieldPlaceHolder;
extern NSString* const kMetadataFieldValidationType;
extern NSString* const kMetadataOutputField;
extern NSString* const kMetadataOutputFieldName;
extern NSString* const kMetadataOutputFieldEmail;
extern NSString* const kMetadataOutputFieldProfilePicture;
extern NSString* const kMetadataValues;

extern NSString* const kMetadataGenderMale;
extern NSString* const kMetadataGenderFemale;

//extern NSString* const kFieldValidationNone;
//extern NSString* const kFieldValidationString;
//extern NSString* const kFieldValidationNumber;
extern NSString* const kFieldValidationEmail;



// Blocks
typedef void (^PVDatePickerBlock) (NSDate* date);
typedef void (^PVDataPickerBlock) (NSString* data);


