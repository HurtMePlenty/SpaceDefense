//
//  Player.m
//  SpaceDefense
//
//  Created by Eliphas on 13.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//

#import "Player.h"
#import "TextureExtractor.h"
#import "BulletSimpleFactory.h"
#import "geoHelper.h"

@interface Player(){
    CCSprite* playerSprite;
    CGSize gameNodeSize;
    BulletSimpleFactory* bsFactory;
    
    
    //weapon settings
    CGPoint shootPoint;
    float weaponDamage;
    float weaponCD; //seconds
    NSDate* lastShootTime;
    
    //some inner settings
    
    float health;
    bool isDead;
    
    
    id<PlayerInterfaceDelegate> interfaceDelegate;
}

@end

@implementation Player


-(id) initWithGameNode:(MainGameLayer*)node InterfaceDelegate:(id<PlayerInterfaceDelegate>)interfaceDel
{
    self = [self init];
    if(self){
        gameNode = node;
        gameNodeSize = node.boundingBox.size;
        bsFactory = [[BulletSimpleFactory alloc] initWithPlayer:self GameNode:gameNode];
        interfaceDelegate = interfaceDel;
        
        isDead = false;
        [self loadStats];
       
    }
    return self;
}

-(void) loadStats {
    //hardcoded weapon stats here
    lastShootTime = [NSDate dateWithTimeIntervalSince1970:0];
    weaponCD = 0.25f;
    weaponDamage = 1.0f;
    
    health = 100.0f;
}

- (void) buildMothership: (NSString*) msImageFile{
    playerSprite = [CCSprite node];
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    CCSpriteFrame* spriteFrame = [frameCache spriteFrameByName:msImageFile];
    [playerSprite setDisplayFrame:spriteFrame];

    //self.contentSize = CGSizeMake(playerSprite.contentSize.width, playerSprite.contentSize.height);
    //playerSprite.position = ccp(playerSprite.contentSize.width / 2, playerSprite.contentSize.height / 2);
    [self addChild:playerSprite];
    //we should set left bottom corner of our player layer after this. All images are centered inside layer object. Just set left bottom corner of layer
}

-(void) spawn {
    [self loadMothership:SCORPION];
}

-(void) loadMothership: (MothershipType) msType {
    
    float shiftX = 0;
    
    switch(msType){
        case DRAGON:
            [self buildMothership:@"dragon.png"];
            shiftX = -50;
            break;
        case SCORPION:
            [self buildMothership:@"scorpion-640.png"];
            shiftX = -25;
            break;
        default:
            [NSException raise:@"UnknownType" format:@"Unknown mothership type"];
            break;
    }
    
    float x = playerSprite.contentSize.width / 2 + shiftX;
    float y = gameNodeSize.height / 2;
    self.position = ccp(x, y);
    [gameNode addChild:self];
}

-(CGPoint) getShootPosition {
    return ccpAdd(self.position, ccp(playerSprite.contentSize.width / 2, 0.0f));
}


-(void) shoot { //should shoot from all? canons here
    lastShootTime = [NSDate date];
    [BulletSimple shootBulletFrom:[self getShootPosition] To:shootPoint WithType:SimplePhoton WithDamage:weaponDamage Speed:(400.0f) FromPlayer:YES];
}

-(void) moveShootPoint: (CGPoint) point {
    shootPoint = point;
}

-(void) startShoot: (CGPoint) point {
    CCLOG(@"startShoot!");
    shootPoint = point;
    if([(NSDate*)[lastShootTime dateByAddingTimeInterval:weaponCD] compare:[NSDate date]] == NSOrderedAscending){
        [self shoot];
    }
    NSTimeInterval secondsLeft = [[lastShootTime dateByAddingTimeInterval:weaponCD] timeIntervalSinceDate:[NSDate date]];
    [self schedule: @selector(shoot) interval:weaponCD repeat:kCCRepeatForever delay: secondsLeft]; //interval in seconds
}

-(void) endShoot {
    CCLOG(@"endShoot!");
    [self unschedule:@selector(shoot)];
}

-(bool)takeHit:(float)damage {
    health -= damage;
    NSLog(@"Player health is now %g", health);
    if(health <= 0 && !isDead)
    {
        [self die];
    }
    return YES;
}

-(CGRect) hitBox {
    CGRect collisionRect = [self getCollisionRect];
    return CGRectApplyAffineTransform(collisionRect, [self nodeToParentTransform]);
}

-(CGRect) getCollisionRect {
    float boxWidth = playerSprite.contentSize.width;
    float boxHeight = playerSprite.contentSize.height;
    
    CGRect rect = CGRectMake(-boxWidth / 2, -boxHeight / 2, boxWidth, boxHeight);
    return rect;
}

-(void) die {
    isDead = true;
    [interfaceDelegate playerDied];
}

#if DEBUG
-(void)draw {
    if(DRAW_HITBOX){
        CGRect collisionRect = [self getCollisionRect];
        ccDrawRect(collisionRect.origin, ccpAdd(collisionRect.origin, ccp(collisionRect.size.width, collisionRect.size.height)));
    }
    [super draw];
}
#endif


@end
