//
//  MainMenu.m
//  SpaceDefense
//
//  Created by Eliphas on 11.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//

#import "MainMenu.h"
#import "HomeScreen.h"

@interface MainMenu(){
    CGSize screenSize;
}
@end

@implementation MainMenu

+(CCScene*) scene {
    CCScene* menuScene = [CCScene node];
    MainMenu* menuLayer = [MainMenu node];
    [menuScene addChild:menuLayer];
    return menuScene;
}

-(id) init
{
    if( (self=[super init])) {
        screenSize = [CCDirector sharedDirector].winSize;
        [self createMenu];
    }
    return self;
}

-(void) createMenu {
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
    [CCMenuItemFont setFontSize:26];
    CCMenuItemFont* playGameItem = [CCMenuItemFont itemWithString:@"Play Game" target:self selector:@selector(playGameHandler:)];
    CCMenuItemFont* options = [CCMenuItemFont itemWithString:@"Options" target:self selector:@selector(optionsHandler:)];
    CCMenu* menu = [CCMenu menuWithItems:playGameItem, options, nil];
    menu.position = ccp(screenSize.width / 2, screenSize.height / 2);
    [menu alignItemsVerticallyWithPadding:40];
    [self addChild:menu];

}

-(void) playGameHandler:(id)sender {
    CCLOG(@"play click");
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0 scene:[HomeScreen scene]]];
}

-(void) optionsHandler:(id)sender {
    
}

@end


