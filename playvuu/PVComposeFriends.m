//
//  PVComposeFriends.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/18/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVComposeFriends.h"
#import "PVComposeFriendViewModel.h"

@interface PVComposeFriends()

@property (nonatomic, strong) NSMutableArray *friends;
@property (nonatomic, strong) NSMutableArray *selected;

@end

@implementation PVComposeFriends

- (id)init
{
    self = [super init];
    if (self) {
        self.friends = [NSMutableArray array];
        self.selected = [NSMutableArray array];
    }
    return self;
}

-(NSArray*) selectedFriends {
    return self.selected;
}

-(NSArray*) allFriends {
    return self.friends;
}

-(void) selectFriend:(PVComposeFriendViewModel*)friendModel {
    [self.selected addObject:friendModel];
}

-(void) unselectFriend:(PVComposeFriendViewModel*)friendModel {
    if ([self.selected containsObject:friendModel]) {
        [self.selected removeObject:friendModel];
    }
}

-(NSInteger) count {
    return [self.friends count];
}

@end
