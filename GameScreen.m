//
//  GameScreen.m
//  SpaceDefense
//
//  Created by Eliphas on 11.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//


#import "GameScreen.h"
#import "MainGameLayer.h"
#import "UILayer.h"
#import "BackgroundLayer.h"
#import "GameManager.h"

@interface GameScreen(){
    CGSize screenSize;
    GameManager* gameManager;
    MainGameLayer* gameLayer;
    UILayer * uiLayer;
    BackgroundLayer* bgLayer;
}
@end

@implementation GameScreen

+(CCScene*) scene {
    CCScene* menuScene = [CCScene node];
    GameScreen* gameScreen = [GameScreen node];
    [menuScene addChild:gameScreen];
    return menuScene;
}

-(id) init
{
    if( (self=[super init])) {
        [self loadResources];
        
        screenSize = [CCDirector sharedDirector].winSize;  
        gameLayer = [MainGameLayer node];
        uiLayer = [UILayer node];
        bgLayer = [BackgroundLayer node];
        gameManager = [[GameManager alloc] initWithGameNode:gameLayer UINode:uiLayer];
        [self addChild:bgLayer z:-1];
        [self addChild:gameLayer z:0];
        [self addChild:uiLayer z:1];
        [self addChild:gameManager];        
     
    }
    return self;
}

-(void) loadResources {
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"ExplosionAtlas.plist"];
    [frameCache addSpriteFramesWithFile:@"BasePack.plist"];
}


@end

