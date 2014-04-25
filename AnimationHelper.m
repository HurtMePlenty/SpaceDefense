//
//  AnimationHelper.m
//  SpaceDefense
//
//  Created by Eliphas on 23.11.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import "AnimationHelper.h"

@implementation CCAnimation (Helper)

+(CCAnimation*) animationWithFrame:(NSString*)frame startFrameIndex:(int)startIndex frameCount:(int)frameCount delay:(float)delay {
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
    for (int i = startIndex; i < startIndex + frameCount; i++)
    {
        NSString* file = [NSString stringWithFormat:@"%@%03i.png", frame, i];
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
        [frames addObject:frame];
    }
    // Return an animation object from all the sprite animation frames
    return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}

@end



@implementation AnimationHelper

+(CCAnimate*) createRedExplosionSimpleAnimation {
    CCAnimation* animation = [CCAnimation animationWithFrame:@"RedExplosionSimple_" startFrameIndex:1 frameCount:24 delay:0.03f];
    CCAnimate* animate = [CCAnimate actionWithAnimation:animation];
    return animate;
}

+(CCAnimate*) createRedExplosionSimple2Animation {
    CCAnimation* animation = [CCAnimation animationWithFrame:@"RedExplosionSimple2_" startFrameIndex:1 frameCount:25 delay:0.03f];
    CCAnimate* animate = [CCAnimate actionWithAnimation:animation];
    return animate;
}


+(CCAnimate*) createRandomRedExplosionSimpleAnimation {
    int type = CCRANDOM_0_1() * 2;
    switch (type) {
        case 0:
            return [AnimationHelper createRedExplosionSimpleAnimation];
        case 1:
            return [AnimationHelper createRedExplosionSimple2Animation];
        default:
            NSLog(@"Explosion animation with type %i not found. Used 1st animation instead", type);
            return [AnimationHelper createRedExplosionSimpleAnimation];
    }
}


@end

