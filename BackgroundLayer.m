//
//  BackgroundLayer.m
//  SpaceDefense
//
//  Created by Eliphas on 18.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//

#import "BackgroundLayer.h"


@implementation BackgroundLayer

-(id) init{
    if(self = [super init])
    {
        [self createBackgroud];
    }
    return self;
}

-(void) createBackgroud{
    CCSprite* bgSprite = [CCSprite spriteWithFile:@"background1.png"];
    bgSprite.anchorPoint = ccp(0.0f, 0.0f);
    [self addChild: bgSprite];
}

@end
