//
//  PVSlideAtlasHelper.h
//  playvuu
//
//  Created by Pablo Vasquez on 9/8/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSourceSize @"sourceSize"

@interface PVSlideAtlasHelper : NSObject
+(NSDictionary *)frameDictWithAlias:(NSString *)alias;
@end
