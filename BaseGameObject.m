//
//  BaseGameObject.m
//  SpaceDefense
//
//  Created by Eliphas on 12.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import "BaseGameObject.h"


@implementation BaseGameObject
@synthesize responsibleFactory;

- (id) init {
    if( (self=[super init])) {
        
	}
	return self;
}

-(id) initWithPlayer:(Player*)player GameNode:(MainGameLayer* )node{
    self = [self init];
    if(self)
    {
        currentPlayer = player;
        gameNode = node;
        
    }
    return self;
}

- (void) redeem {
    [self unscheduleUpdate];
    [self.parent removeChild: self];
    [self.responsibleFactory redeemGameObject:self];
}

-(void) spawnAtPoint:(CGPoint)point{
    self.position = point;
    [gameNode addChild:self];
}



-(void) activate {
    
}

-(CGRect) hitBox{
    return self.boundingBox;
}

-(bool) takeHit: (float) damage {
    return NO;
}


#if DEBUG
-(void)draw {
    if(DRAW_HITBOX) {
        CGRect rect = [self boundingBox];
        ccDrawRect(ccp(0,0),ccp(rect.size.width,rect.size.height));
    }
    [super draw];
}
#endif




@end
