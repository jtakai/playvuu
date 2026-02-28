//
//  NSBundle+Loading.h
//  playvuu
//
//  Created by Nicolas Miyasato on 9/15/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Loading)

// Does exactly what the name says, and if there is no nib with that class,
// it'll return nil.
-(id) loadFirstNibNamedWithNoOwner:(Class)klass;

@end
