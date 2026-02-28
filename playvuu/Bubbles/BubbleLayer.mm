#import "BubbleLayer.h"
#import "BubbleConfig.h"
#import "PVVideoSprite.h"
#import "TestFlight.h"
#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@implementation BubbleLayer

+ (id)scene {
    
    CCScene *scene = [CCScene node];
    BubbleLayer *layer = [BubbleLayer node];
    [scene addChild:layer];
    return scene;
}


static const NSString *x = @"x";
static const NSString *y = @"y";

/* Array with initial ball positions.*/
NSArray * ballPositions = @[
                            @{x : @4.0f, y : @10.0f },]; // ball 1
                            /*@{x : @4.0f, y : @7.0f },  // .
                            @{x : @4.0f, y : @4.0f },  // .
                            @{x : @7.0f, y : @10.0f }, // .
                            @{x : @7.0f, y : @7.0f },  // .
                            @{x : @7.0f, y : @4.0f }   // ball 6
                            ];*/


- (id)init {
    
    if ((self=[super initWithColor:ccc4(128, 128, 128, 255)])) {
        CCDirector *director = [CCDirector sharedDirector];
        CGSize winSize = [self boundingBox].size;
        
        _bubbleWorld = new PVBubbleWorld(winSize.width/PTM_RATIO, winSize.height/PTM_RATIO);
        _world = _bubbleWorld->m_world;
        
/*        for(NSDictionary *ballPos in ballPositions){
            float32 xPos = [(NSNumber *)[ballPos valueForKey:@"x"] floatValue];
            float32 yPos = [(NSNumber *)[ballPos valueForKey:@"y"] floatValue];
            [self createBubble:(PVBubbleWorld::E_GROW) x:xPos y:yPos];
        }*/
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
        [director.view addGestureRecognizer:panGestureRecognizer];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
        [director.view addGestureRecognizer:tapGestureRecognizer];
        
        [self schedule:@selector(tick:)];
        //[self setTouchEnabled:YES];
        //[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        //[self setAccelerometerEnabled:YES];
    }
    return self;
}

-(int32)createBubble:(PVBubbleWorld::AddMethod)method x:(float32)xPos y:(float32)yPos{
    int cnt = _bubbleWorld->m_cnt;
    
    if(cnt < PVBubbleWorld::e_count-1){
        
        // newBubble must be called before the sprite creation, or the tick method
        // will fall into sprite destruction.
        _bubbleWorld->newBubble(NULL, xPos, yPos, BUBBLE_DIAMETER/(PTM_RATIO*2));
        ballRadius[cnt] = BUBBLE_SPRITE/(PTM_RATIO*2); //Even if this order guarantees nothing.
        PVVideoSprite *ball = [[PVVideoSprite alloc] initWithRect:CGRectMake(0, 0, BUBBLE_SPRITE, BUBBLE_SPRITE)];
        balls[cnt] = ball;
        ball.position = ccp((xPos+1)*3*PTM_RATIO, (yPos+1)*3*PTM_RATIO);
        [self addChild:ball];
        NSLog(@"Created bubble at (%f,%f)", xPos, yPos);
    }
    
    return _bubbleWorld->m_cnt;
}

- (void)tick:(ccTime) dt {
    //static int32 cycle = 0;
    
    _bubbleWorld->Step(dt);
    int32 bodyCnt = _bubbleWorld->m_cnt;
    
    for(int i = 0; i<bodyCnt; i++){
        b2Body * b = _bubbleWorld->m_bodies[i];
        CCSprite *ballData = balls[i];
        
        if (b!= NULL && ballData != NULL) {
            [ballData setPosition:ccp(b->GetWorldCenter().x * PTM_RATIO, b->GetWorldCenter().y * PTM_RATIO)];
            
            if(_bubbleWorld->m_bodyRadius[i] != ballRadius[i]){
                [ballData setScale:_bubbleWorld->m_bodyRadius[i]/(BUBBLE_SPRITE/(PTM_RATIO*2))];
                ballRadius[i] = _bubbleWorld->m_bodyRadius[i];
            }
        }else if(b == NULL && ballData != NULL){
            [self releaseSpriteAtIndex:i];
        }
    }
}

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer{
    
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    int32 idx = _bubbleWorld->queryWorld(b2Vec2(touchLocation.x/PTM_RATIO, touchLocation.y/PTM_RATIO));
    if(idx == -1)
        [self createBubble:PVBubbleWorld::E_GROW x:touchLocation.x/PTM_RATIO y:touchLocation.y/PTM_RATIO];
    else {
        //[balls[idx] toggleVideo];
    }
}

- (void)releaseSpriteAtIndex:(int) i{
    PVVideoSprite *remove = balls[i];
    if(remove){
        //[remove stopVideo];
        [self removeChild:remove cleanup:YES];
        balls[i] = NULL;
    }
}

- (void)resetBubbles{
    int cnt = _bubbleWorld->m_cnt;
    for(int i = 0; i<cnt; i++){
        _bubbleWorld->removeBubble(i);
        [self releaseSpriteAtIndex:i];
    }
}


- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    static CGPoint touchLocation;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];
        [self ccTouchBegan:touchLocation];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged){
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = ccp(translation.x, -translation.y);
        touchLocation = ccpAdd(touchLocation, translation);
        [self ccTouchMoved:touchLocation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = ccp(translation.x, -translation.y);
        touchLocation = ccpAdd(touchLocation, translation);
        [self ccTouchEnded:touchLocation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];        
    }        
}

//
// These three down here have to be renamed to something not coco2d-like
//

- (BOOL)ccTouchBegan:(CGPoint)touchLocation {
    //CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    int32 idx = _bubbleWorld->MouseDown(b2Vec2(touchLocation.x/PTM_RATIO, touchLocation.y/PTM_RATIO), 0);
    if(idx != -1){
        CCSprite *touchedBall = balls[idx];
        _bubbleWorld->m_bodyRadius[idx] += 4/PTM_RATIO;
        [self reorderChild:touchedBall z:0];
        [touchedBall setOpacity:180];
    }
    return TRUE;
}

- (void)ccTouchMoved:(CGPoint) touchLocation {
    _bubbleWorld->MouseMove(b2Vec2(touchLocation.x/PTM_RATIO, touchLocation.y/PTM_RATIO));
}

- (void)ccTouchEnded:(CGPoint)touchLocation{
    //CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    int32 idx = _bubbleWorld->MouseUp(b2Vec2(touchLocation.x/PTM_RATIO, touchLocation.y/PTM_RATIO));
    if(idx != -1){
        CCSprite *touchedBall = balls[idx];
        _bubbleWorld->m_bodyRadius[idx] -= 4/PTM_RATIO;
        [touchedBall setOpacity:255];
    }

}

-(PVVideoSprite *)getBubbleAtIndex:(int)idx{
    return balls[idx];
}

@end