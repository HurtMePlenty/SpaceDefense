//
//  EnemySimple.h
//  SpaceDefense
//
//  Created by Eliphas on 12.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseGameObject.h"

typedef enum {
    PIRATE,
    SCOUT
} EnemySimpleType;


@interface EnemySimple : BaseGameObject

-(bool) takeHit: (float)damage;
-(void) buildWithType: (EnemySimpleType) type Health:(float)health;

@end
