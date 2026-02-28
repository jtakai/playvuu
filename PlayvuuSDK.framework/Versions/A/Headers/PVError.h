//
//  PVError.h
//  PlayvuuSDK
//
//  Created by Brian Smith on 7/1/13.
//  Copyright (c) 2013 Playvuu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * kPVErrorDomain;

typedef enum
{
    PVErrorNone = 0,

    PVErrorNoVideoSource = 100,
    PVErrorNoMovieWriter,

    PVErrorAlreadyActive,
    PVErrorAlreadyRecording,
    
    PVErrorUnknown = 9999
    
} PVErrorType;


@interface PVError : NSError

+ (PVError *) error;
+ (PVError *) error:(PVErrorType)code;
+ (PVError *) error:(PVErrorType)code userInfo:(NSDictionary *)dict;

@end
