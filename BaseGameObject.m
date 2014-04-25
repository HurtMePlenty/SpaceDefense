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
}

-(void) pause {
    
}


-(void) activate {
    [NSException raise:@"NotImplemented" format:@"activate should be implemented in child"];
}

-(CGRect) hitBox{
    [NSException raise:@"NotImplemented" format:@"hitBox should be implemented in child"];
}

-(bool) takeHit: (float) damage {
    return NO;
}




@end
