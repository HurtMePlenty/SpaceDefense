//
//  EnemySimple.m
//  SpaceDefense
//
//  Created by Eliphas on 12.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//

#import "EnemySimple.h"
#import "TextureExtractor.h"
#import "SpeedHelper.h"
#import "AnimationHelper.h"



@interface EnemySimple() {
    EnemySimpleType currentType;
    float maxHealth;
    float currentHealth;
    float speed;    
    CGPoint velocity;    
    float crashDamage;
    
    bool wasShown; //we should show our object on the game screen, before checking if it has left it
    bool isDead;
    
    CCSprite* enemySprite;
    CCSprite* explosionSprite;
}

@end

@implementation EnemySimple

-(void)activate {
    [self moveOnPlayerSimple];
    [self scheduleUpdate];
}

-(void) moveOnPlayerSimple {
    velocity = ccp(-speed, 0);
}

-(void) spawnAtPoint:(CGPoint)point {
    [super spawnAtPoint:point];
    [self pullAllComponents];
}

-(void)buildWithType:(EnemySimpleType)type Health:(float)health {
    
    maxHealth = currentHealth = health;
    switch (type) {
        case PIRATE:
            currentType = PIRATE;
            [self buildPirate];
        break;
        
        case SCOUT:
        
        break;
            
            
        default:
            [NSException raise:@"Unknown simple enemy type" format:nil];
            break;
    }
}

-(void) cleanContent {
    wasShown = false;
    isDead = false;
    [self removeAllChildren];
    [[gameNode mainBatchNode] removeChild:enemySprite];
    [[gameNode explosionNode] removeChild:explosionSprite];
    enemySprite = nil;
    explosionSprite = nil;
}

-(void) buildPirate {
    speed = 150.0f;
    crashDamage = 20.0f;
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    CCSpriteFrame* spriteFrame = [frameCache spriteFrameByName:@"enemy1-128.png"];
    enemySprite = [CCSprite spriteWithSpriteFrame:spriteFrame];
    
    [gameNode addChild:self];
    [[gameNode mainBatchNode] addChild:enemySprite];

    
}

-(void) buildScout {
    
}

-(float) getWidth {
    return self.contentSize.width; //we should calculate complex width here
}

-(bool)takeHit:(float)damage {
    if(isDead)
    {
        return NO;
    }
    currentHealth -= damage;
    NSLog(@"My health is now %g", currentHealth);
    if(currentHealth <= 0) {
        [self destroy];
    }
    return YES;
}

-(void) destroy {
    isDead = true;
    CCAnimate* anim = [AnimationHelper createRandomRedExplosionSimpleAnimation];
    
    CCCallBlock* redeemAction = [CCCallBlock actionWithBlock:^void(){
        [self redeem];
    }];
    CCSequence* seq = [CCSequence actions:anim, redeemAction, nil];

    explosionSprite = [CCSprite spriteWithTexture:[[gameNode explosionNode] texture] rect:CGRectZero];
    explosionSprite.position = self.position;
    
    [enemySprite setVisible:NO];
    
    [[gameNode explosionNode] addChild:explosionSprite];
    [explosionSprite runAction:seq];
    
    
    [self unscheduleUpdate];
}

-(void) pullAllComponents {
    enemySprite.position = self.position;
}

-(void)update:(ccTime)delta {
    
    self.position = ccpAdd(self.position, getWorldVelocity(ccp(velocity.x * delta, velocity.y * delta)));
    [self pullAllComponents];


    if(!CGRectIntersectsRect(self.hitBox, gameNode.boundingBox))
    {
        if(wasShown){
            [self redeem];
        }
    } else {
        wasShown = true;
    }
    
    if(CGRectIntersectsRect(self.hitBox, currentPlayer.hitBox))
    {
        [currentPlayer takeHit:crashDamage];
        [self destroy]; //todo special crash animation?
    }
}

-(void)redeem {
    [super redeem];
    [self cleanContent];
}

-(CGRect) hitBox {
    CGRect collisionRect = [self getCollisionRect];
    return CGRectApplyAffineTransform(collisionRect, [self nodeToParentTransform]);
}

-(CGRect) getCollisionRect {
    float boxWidth = enemySprite.contentSize.width;
    float boxHeight = enemySprite.contentSize.height;

    CGRect rect = CGRectMake(-boxWidth / 2, -boxHeight / 2, boxWidth, boxHeight);
    return rect;
}

-(void) pause {
    [self pauseSchedulerAndActions];
    if(explosionSprite){
        [explosionSprite pauseSchedulerAndActions];
    }
}

#if DEBUG
-(void) draw {
    CGRect collisionRect = [self getCollisionRect];
    ccDrawRect(collisionRect.origin, ccpAdd(collisionRect.origin, ccp(collisionRect.size.width, collisionRect.size.height)));
    [super draw];
}
#endif



@end
