//
//  ReelStopInformation.m
//  TestingPicker
//
//  Created by MN on 7/31/13.
//  Copyright (c) 2013 MN. All rights reserved.
//

#import "ReelStopInformation.h"

@implementation ReelStopInformation

@synthesize reel = _reel;
@synthesize component = _component;

@synthesize stop = _stop;
@synthesize logicStop = _logicStop;
@synthesize logicCount = _logicCount;

@synthesize index = _index;
@synthesize spinning = _spinning;

@synthesize imageView = _imageView;
@synthesize frame = _frame;


-(id)init
{
    self = [super init];
    if (self)
    {
        self.stop = 0;
        self.spinning = NO;
    }
    return self;
}
-(NSString*)description
{
    return [NSString stringWithFormat:@"%@ | stop:%d logicStop:%d logicCount:%d index:%d spinnig:%d",
            [super description], self.stop, self.logicStop, self.logicCount, self.index, self.spinning];
}
@end
