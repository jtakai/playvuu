//
//  ReelStopInformation.h
//  TestingPicker
//
//  Created by MN on 7/31/13.
//  Copyright (c) 2013 MN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReelStopInformation : NSObject

@property (nonatomic, strong) NSArray * reel;
@property (nonatomic, assign) NSUInteger component;

@property (nonatomic, assign) NSUInteger stop;
@property (nonatomic, assign) NSUInteger logicStop;
@property (nonatomic, assign) NSUInteger logicCount;

@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) BOOL spinning;

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, assign) NSUInteger frame;

@end
