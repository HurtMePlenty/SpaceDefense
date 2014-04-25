//
//  WaveConstructor.h
//  SpaceDefense
//
//  Created by Eliphas on 15.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayerInputDelegate.h"
#import "PlayerInterfaceDelegate.h"
#import "MainGameLayer.h"


@interface GameManager : CCNode <PlayerInputDelegate, PlayerInterfaceDelegate>

-(id) initWithGameNode:(MainGameLayer*)node UINode:(CCNode*)interfaceNode;


@end
