//
//  GameObjectFactory.m
//  SpaceDefense
//
//  Created by Eliphas on 12.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import "GameObjectFactory.h"

@implementation GameObjectFactory
@synthesize reusableObjects, objectsInUse;

-(id) init{
    if( (self=[super init])) {
        reusableObjects = [NSMutableArray arrayWithCapacity:20];
        objectsInUse = [NSMutableArray arrayWithCapacity:20];
	}	
	return self;
}

-(id) initWithPlayer:(Player*)player GameNode:(MainGameLayer*)node{
    self = [self init];
    if(self)
    {
        gameNode = node;
        currentPlayer = player;
    }
    return self;
}

-(void) redeemGameObject:(id)object{
    [reusableObjects addObject:object];
    [objectsInUse removeObject:object];
    
}


@end
