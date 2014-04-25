//
//  SimpleGameObject.h
//  SpaceDefense
//
//  Created by Eliphas on 25.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"
#import "GameObjectFactory.h"
#import "Player.h"
#import "MainGameLayer.h"

@interface SimpleGameObject : CCSprite
{
    @protected
    MainGameLayer* __weak gameNode;
    Player* currentPlayer;
    
}

@property (nonatomic) GameObjectFactory* responsibleFactory;

-(CGRect) hitBox;
-(void) activate;
-(void) redeem;
-(void) spawnAtPoint:(CGPoint)point;
-(void) renderMe;
-(id) initWithPlayer:(Player*)player GameNode:(MainGameLayer*)node;
-(bool) takeHit: (float) damage;
-(void) pause;
@end

