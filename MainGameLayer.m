//
//  MainGameLayer.m
//  SpaceDefense
//
//  Created by Eliphas on 13.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//

#import "MainGameLayer.h"
#import "Player.h"
#import "PlayerStats.h"


#import "TextureExtractor.h"
#import "AnimationHelper.h"



@interface MainGameLayer(){
    Player* player;
    CCSpriteBatchNode* mainBatchNode;
    CCSpriteBatchNode* explosionsBatchNode;
}
@end

@implementation MainGameLayer
-(id) init
{
    if( (self=[super init])) {
        self.touchEnabled = YES;
        [self createBatchNodes];
    }
    return self;
}

///TEST METHOD
-(void) testAnimation {
    //CCAnimation* animation = [CCAnimation animationWithFrame:@"RedExplosionSimple_" startFrameIndex:1 frameCount:24 delay:0.04f];
    //CCAnimate* animate = [CCAnimate actionWithAnimation:animation];
    //CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
    
    CCSprite* testSprite = [[CCSprite alloc] init];
    testSprite.position = ccp(0,0);
    
    CCTexture2D* texture = [[TextureExtractor instance] getTextureByName:@"beam1.png"];
    testSprite.texture = texture;
    [testSprite setTextureRect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];

    
    [self addChild:testSprite];
    //[testSprite runAction:repeat];
    
   // [self runAction:repeat];
    
}


-(void) registerWithTouchDispatcher
{
    [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self
                                                            priority:INT_MIN+1
                                                     swallowsTouches:YES];
}

-(void) createBatchNodes {
    mainBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"BasePack.png"];
    [self addChild:mainBatchNode z:1];
    
    explosionsBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"ExplosionAtlas.png"];

    [self addChild:explosionsBatchNode z:2];
    
}

-(CCSpriteBatchNode*) mainBatchNode{
    return mainBatchNode;
}

-(CCSpriteBatchNode*) explosionNode {
    return explosionsBatchNode;
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    [self.playerInputDelegate playerStartShootPoint:location];
    
    return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [self.playerInputDelegate playerEndShoot];  
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    [self.playerInputDelegate playerEndShoot];
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    [self.playerInputDelegate playerMoveShootPoint:location];
}




@end
