//
//  PVLayer.h
//  PlayvuuSDK
//
//  Created by Brian Smith on 8/23/13.
//  Copyright (c) 2013 Brian Smith. All rights reserved.
//

#import <GPUImage/GPUImage.h>

@interface PVLayer : NSObject

@property (nonatomic,strong) NSDictionary * parameters;

@property (nonatomic,readonly) GPUImageOutput<GPUImageInput> * input;
@property (nonatomic,readonly) GPUImageOutput * output;

@property (nonatomic,readonly) NSString * layerName;


+ (PVLayer *) newLayerFromName:(NSString *)layerName;
+ (void) registerLayerClass:(Class)class;

- (void) setParameter:(NSString *)name withValue:(id)value;

@end
