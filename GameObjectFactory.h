//
//  GameObjectFactory.h
//  SpaceDefense
//
//  Created by Eliphas on 12.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"
#import "MainGameLayer.h"

@interface GameObjectFactory : NSObject
{
    @protected
    MainGameLayer* __weak gameNode;
    Player* currentPlayer;
    
}

@property (nonatomic, readonly) NSMutableArray* reusableObjects;
@property (nonatomic, readonly) NSMutableArray* objectsInUse;

-(void) redeemGameObject:(id)object;
-(id) initWithPlayer:(Player*)player GameNode:(MainGameLayer*)node;


@end
