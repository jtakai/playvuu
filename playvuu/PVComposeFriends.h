//
//  PVComposeFriends.h
//  playvuu
//
//  Created by Nicolas Miyasato on 9/18/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PVComposeFriendViewModel;

@interface PVComposeFriends : NSObject

-(NSArray*) selectedFriends;
-(NSArray*) allFriends;
-(void) selectFriend:(PVComposeFriendViewModel*)friendModel;
-(void) unselectFriend:(PVComposeFriendViewModel*)friendModel;
-(NSInteger) count;

@end
