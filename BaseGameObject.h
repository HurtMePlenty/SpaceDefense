//
//  BaseGameObject.h
//  SpaceDefense
//
//  Created by Eliphas on 12.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObjectFactory.h"
#import "Player.h"
#import "MainGameLayer.h"

@interface BaseGameObject : CCNode
{
    BOOL wasRendered;
    @protected
    MainGameLayer* __weak gameNode;
    Player* currentPlayer;
}

@property (nonatomic) GameObjectFactory* responsibleFactory;
-(CGRect) hitBox;
-(void) activate;
-(void) redeem;
-(void) spawnAtPoint:(CGPoint)point;
-(bool) takeHit: (float) damage;
-(id) initWithPlayer:(Player*)player GameNode:(MainGameLayer*)node;
@end
