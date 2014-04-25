//
//  SimpleGameObject.m
//  SpaceDefense
//
//  Created by Eliphas on 25.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import "SimpleGameObject.h"


@implementation SimpleGameObject
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
    [self.parent removeChild:self];
    [self unscheduleUpdate];
    if(self.parent != nil)
    {
        CCLOG(@"ALREADY GOT PARENT");
    }
    [self.responsibleFactory redeemGameObject:self];
}

-(void) spawnAtPoint:(CGPoint)point{
    self.position = point;
    
}

-(void)renderMe{
    
}

-(void)activate {
    
}

-(void)pause {
    
}

-(CGRect) hitBox {
    return [self boundingBox];
}

-(bool) takeHit: (float) damage {
    return NO;
}

#if DEBUG
-(void)draw { //won't be called if we use CCSpriteBatchNode
    if(DRAW_HITBOX){
        CGRect rect = [self boundingBox];
        ccDrawRect(ccp(0,0), ccp(rect.size.width,rect.size.height));
    }
    [super draw];
}
#endif
 
 

@end
