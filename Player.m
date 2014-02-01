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
}

@end

@implementation Player
@synthesize rightBorder;


-(id) initWithGameNode:(MainGameLayer*)node{
    self = [self init];
    if(self){
        gameNode = node;
        gameNodeSize = node.boundingBox.size;
        bsFactory = [[BulletSimpleFactory alloc] initWithPlayer:self GameNode:gameNode];
        
        [self loadStats];
       
    }
    return self;
}

-(void) loadStats {
    //hardcoded weapon stats here
    lastShootTime = [NSDate dateWithTimeIntervalSince1970:0];
    weaponCD = 0.5f;
    weaponDamage = 1.0f;
    
    health = 100.0f;
}

- (void) renderMe{
    playerSprite = [CCSprite node];
    CCTexture2D* texture = [[TextureExtractor instance] getTextureByName:@"ms2.png"];
    playerSprite.texture = texture;
    [playerSprite setTextureRect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];
    self.contentSize = CGSizeMake(texture.contentSize.width, texture.contentSize.height);
    self.anchorPoint = ccp(0.5f, 0.5f);
    playerSprite.position = ccp(texture.contentSize.width / 2, texture.contentSize.height / 2);
    [self addChild:playerSprite];
}

-(void) spawn {
    if(!playerSprite)
    {
        [self renderMe];
    }
    
    float shiftX = -self.contentSize.width / 6.5f;
    
    self.rightBorder = self.contentSize.width / 2 + shiftX;
    self.position = ccp(shiftX, gameNodeSize.height / 2);
    [gameNode addChild:self];
}

-(CGPoint) getShootPosition {
    return ccpAdd(self.position, CGPointMake(128.0f, 0));
}


-(void) shoot { //should shoot from all? canons here
    lastShootTime = [NSDate date];
    [BulletSimple shootBulletFrom:[self getShootPosition] To:shootPoint WithType:SimplePhoton WithDamage:weaponDamage Speed:(150.0f) FromPlayer:YES];
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
    NSTimeInterval milisecondsLeft = [[lastShootTime dateByAddingTimeInterval:weaponCD] timeIntervalSinceDate:[NSDate date]];
    [self schedule: @selector(shoot) interval:weaponCD repeat:kCCRepeatForever delay: milisecondsLeft]; //interval in seconds
}

-(void) endShoot {
    CCLOG(@"endShoot!");
    [self unschedule:@selector(shoot)];
}

@end
