//
//  MainGameLayer.h
//  SpaceDefense
//
//  Created by Eliphas on 13.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayerInputDelegate.h"

#define DRAW_HITBOX 0

@interface MainGameLayer : CCLayer {
    
}
@property (nonatomic) id<PlayerInputDelegate> playerInputDelegate;
-(CCSpriteBatchNode*) mainBatchNode;

@end
