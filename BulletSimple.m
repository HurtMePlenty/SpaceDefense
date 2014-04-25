//
//  BulletSimple.m
//  SpaceDefense
//
//  Created by Eliphas on 22.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//

#import "BulletSimple.h"
#import "TextureExtractor.h"
#import "geoHelper.h"
#import "EnemySimpleFactory.h"
#import "BulletSimpleFactory.h"

#import "SpeedHelper.h"


@interface BulletSimple(){
    
    CGPoint target;
    CGPoint velocity;    
    float currentSpeed;
    float currentDamage;
    bool isPlayerBullet;
    BulletSimpleType currentType;
    
}

@end

@implementation BulletSimple

+(void) shootBulletFrom:(CGPoint)startPoint To:(CGPoint)targetPoint WithType:(BulletSimpleType)type WithDamage:(float) damage Speed:(float)speed FromPlayer:(bool)isFromPlayer {
    BulletSimpleFactory* sharedBF = [BulletSimpleFactory sharedInstance];
    BulletSimple* bs = [sharedBF createBullet];
    if(bs.parent != nil)
    {
        CCLOG(@"SHIT! ALREADY IN SCENE!");
    }
    [bs buildWithType:type Damage:damage Speed:speed FromPlayer:isFromPlayer];
    [bs spawnAtPoint:startPoint];
    [bs moveToPoint:targetPoint];
}

-(void) buildWithType:(BulletSimpleType)type Damage:(float)damage Speed:(float)speed FromPlayer:(bool)isFromPlayer {
    currentType = type;
    currentSpeed = speed;
    currentDamage = damage;
    isPlayerBullet = isFromPlayer;
    
    switch (type) {
        case SimplePhoton:
            [self buildSimplePhoton];
            break;
            
        default:
            [NSException raise:@"UnknownType" format:@"Unknown simple bullet type"];
            break;
    }
    
    
}

-(void)moveToPoint:(CGPoint)point{
    float dx = point.x - self.position.x;
    float dy = point.y - self.position.y;
    float distance = ccpDistance(self.position, point);
    float ratio = ([self speed] / distance);
    velocity = CGPointMake(ratio * dx, ratio * dy);
    
    //rotate the bullet
    float angleRadians = atanf((float)dy / (float)dx);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    float cocosAngle = -1 * angleDegrees;
    self.rotation = cocosAngle;
    
    [self scheduleUpdate];
}

-(void) buildSimplePhoton {
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    CCSpriteFrame* spriteFrame = [frameCache spriteFrameByName:@"beam1.png"];
    [self setDisplayFrame:spriteFrame];
    [[gameNode mainBatchNode] addChild:self];
  

}

-(void)update:(ccTime)delta{
    self.position = ccpAdd(self.position, getWorldVelocity(ccpMult(velocity, delta)));
    
    //out of screen check
    if(!CGRectIntersectsRect(self.boundingBox, gameNode.boundingBox))
    {
        [self redeem];
        return;
    }
    
    for(SimpleGameObject* enemy in  [EnemySimpleFactory sharedInstance].objectsInUse)
    {
        if(CGRectIntersectsRect(self.hitBox, enemy.hitBox))
        {
            bool wasHit = [enemy takeHit:currentDamage]; 
            if(wasHit){                
                [self redeem]; //we can't redeem the same bullet twice
                //CCLOG(@"HIT!!");
                return; //we can hit only 1 enemy with our bullet
            }
        }
    }
}

-(void)redeem{
    [super redeem];
    //CCLOG(@"BulletSimple was redeemed!! :)");
}

-(float)speed
{
    return currentSpeed;
}

-(void) pause {
    [self pauseSchedulerAndActions];
}


@end
