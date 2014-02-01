//
//  HomeScreen.m
//  SpaceDefense
//
//  Created by Eliphas on 11.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//

#import "HomeScreen.h"
#import "GameScreen.h"

@interface HomeScreen(){
    CGSize screenSize;
}
@end

@implementation HomeScreen

+(CCScene*) scene {
    CCScene* menuScene = [CCScene node];
    HomeScreen* menuLayer = [HomeScreen node];
    [menuScene addChild:menuLayer];
    return menuScene;
}

-(id) init
{
    if( (self=[super init])) {
        screenSize = [CCDirector sharedDirector].winSize;
        [self createButtons];
    }
    return self;
}

- (void) createButtons {
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
    [CCMenuItemFont setFontSize:26];
    CCMenuItemFont* label = [CCMenuItemFont itemWithString:@"Play" target:self selector:@selector(playHandler:)];
    CCMenu* menu = [CCMenu menuWithItems:label, nil];
    menu.position = ccp(label.contentSize.width, label.contentSize.height);
    [self addChild:menu];
}

-(void) playHandler:(id)sender{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[GameScreen scene]]];
}



@end

