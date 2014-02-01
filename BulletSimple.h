//
//  BulletSimple.h
//  SpaceDefense
//
//  Created by Eliphas on 22.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleGameObject.h"
#import "cocos2d.h"


typedef enum {
    SimplePhoton
} BulletSimpleType;

@interface BulletSimple : SimpleGameObject {
    
}

+(void) shootBulletFrom:(CGPoint)startPoint To:(CGPoint)targetPoint WithType:(BulletSimpleType)type  WithDamage:(float) damage Speed:(float)speed FromPlayer:(bool)isFromPlayer;

-(void) buildWithType:(BulletSimpleType)type Damage:(float)damage Speed:(float)speed FromPlayer:(bool)isFromPlayer;
-(void)moveToPoint:(CGPoint)point;

@end
