#import "cocos2d.h"
#import "PVBubbleWorld.h"
#import "PVVideoSprite.h"

@interface BubbleLayer : CCLayerColor {
    b2World *_world;
    b2Body *_body;
    CCSprite *_ball;
    PVBubbleWorld *_bubbleWorld;
    float32 ballRadius[PVBubbleWorld::e_count];
    PVVideoSprite *balls[PVBubbleWorld::e_count];
}

+ (id) scene;
-(int32)createBubble:(PVBubbleWorld::AddMethod)method x:(float32)xPos y:(float32)yPos;
-(PVVideoSprite *)getBubbleAtIndex:(int)idx;
- (void)resetBubbles;

@end
