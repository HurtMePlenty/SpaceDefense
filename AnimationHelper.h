//
//  AnimationHelper.h
//  SpaceDefense
//
//  Created by Eliphas on 23.11.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCAnimation (Helper)

+(CCAnimation*) animationWithFrame:(NSString*)frame startFrameIndex:(int)startIndex frameCount:(int)frameCount delay:(float)delay;

@end

@interface AnimationHelper : NSObject

+(CCAnimate*) createRedExplosionSimpleAnimation;
+(CCAnimate*) createRedExplosionSimple2Animation;
+(CCAnimate*) createRandomRedExplosionSimpleAnimation;

@end
