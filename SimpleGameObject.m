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
    self.visible = NO;
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
    self.visible = YES;
}

-(void)renderMe{
    
}

-(void)activate {
    
}

-(CGRect) hitBox {
    return self.boundingBox;
}

-(float)speed{
    return 0.0f;
}

#if DEBUG
-(void)draw {
    if(DRAW_HITBOX){
        CGRect rect = [self boundingBox];
        ccDrawRect(ccp(0,0),ccp(rect.size.width,rect.size.height));
    }
    [super draw];    
}
#endif
 
 

@end
