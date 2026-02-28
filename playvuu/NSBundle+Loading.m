//
//  NSBundle+Loading.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/15/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "NSBundle+Loading.h"

@implementation NSBundle (Loading)

-(id) loadFirstNibNamedWithNoOwner:(Class)klass {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(klass)
                                          owner:nil
                                        options:nil] lastObject];

}
@end
