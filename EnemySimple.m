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
    CCSprite* selfSprite;
    
    EnemySimpleType currentType;
    float maxHealth;
    float currentHealth;
    float speed;    
    CGPoint velocity;    
    bool wasShown; //we should show our object on the game screen, before checking if it has left it
    bool isDead;
}

@end

@implementation EnemySimple

-(void)activate {    
    [self moveOnPlayerSimple];
    [self scheduleUpdate];
    //CGPoint targetPoint = ccp(-self.contentSize.width/2, self.position.y);
    //CCMoveTo* moveTo = [CCMoveTo actionWithDuration:7.0f position:targetPoint];
    //[self runAction:moveTo];

}

-(void) moveOnPlayerSimple {
    velocity = ccp(-speed, 0);
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
    [self removeAllChildren];  //we should extend this logic after using batch;
}

-(void) buildPirate {
    selfSprite = [CCSprite node];   

    CCTexture2D* texture = [[TextureExtractor instance] getTextureByName:@"pirate.png"];
    selfSprite.texture = texture;
    [selfSprite setTextureRect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];
    self.contentSize = CGSizeMake(texture.contentSize.width, texture.contentSize.height);
    self.anchorPoint = ccp(0.5f, 0.5f);
    selfSprite.position = ccp(texture.contentSize.width / 2, texture.contentSize.height / 2);
    
    speed = 150.0f;
    
    [self addChild:selfSprite];
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
    NSLog(@"I was destroyed!!!");
    CCAnimate* anim = [AnimationHelper createRandomRedExplosionSimpleAnimation];
    
    CCCallBlock* redeemAction = [CCCallBlock actionWithBlock:^void(){
        [self redeem];
    }];
    
    CCSequence* seq = [CCSequence actions:anim, redeemAction, nil];
    [selfSprite runAction: seq];
    [self unscheduleUpdate];
    //[self redeem];
}

-(void)update:(ccTime)delta {
    self.position = ccpAdd(self.position, getWorldVelocity(ccp(velocity.x * delta, velocity.y * delta)));

    if(!CGRectIntersectsRect(self.boundingBox, gameNode.boundingBox))
    {
        if(wasShown){
            [self redeem];
        }
    } else {
        wasShown = true;
    }    
}

-(void)redeem {
    [super redeem];
    [self cleanContent];
    NSLog(@"EnemySimple was redeemed! :)");
}



@end
