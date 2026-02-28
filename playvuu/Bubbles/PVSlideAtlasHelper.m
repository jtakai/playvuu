//
//  PVSlideAtlasHelper.m
//  playvuu
//
//  Created by Pablo Vasquez on 9/8/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVSlideAtlasHelper.h"

#define kSpriteSize @"spriteSize"
#define kSpriteOffset @"spriteOffset"
#define kSpriteSourceSize @"spriteSourceSize"
#define kTextureRect @"textureRect"
#define kYextureRotated @"textureRotated"
#define kAliases @"aliases"
#define kMetadata @"metadata"
#define kFrames @"frames"
#define kFormat @"format"

@implementation PVSlideAtlasHelper

+(NSDictionary *)frameDictWithAlias:(NSString *)alias{
    NSMutableDictionary *newDict;
    for(int i=0; i<4; i++){
        NSArray *frameName = @[[NSString stringWithFormat:@"%@_%d.png", alias, i ]];
        NSString * textureRect = [NSString stringWithFormat:@"(%d, %d, 256, 256)", 256*(i%2), 256*(i/2) ];
        NSDictionary *frameDict = @{ kSpriteSize : @"(256, 256)",
                                    kSpriteOffset: @"(0,0)",
                                    kSpriteSourceSize: @"(256, 256)",
                                    kTextureRect: textureRect,
                                    //kAliases:frameAlias
                                    };
        [newDict setObject:frameDict forKey:frameName];
    }
    
    [newDict setObject:@{kFormat:@3} forKey:kMetadata];
    
    return newDict;
}

@end
