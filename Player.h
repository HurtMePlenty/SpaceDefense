//
//  Player.h
//  SpaceDefense
//
//  Created by Eliphas on 13.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainGameLayer.h"
#import "PlayerInterfaceDelegate.h"


typedef enum {
    DRAGON,
    SCORPION
} MothershipType;

@interface Player : CCNode {
    MainGameLayer* __weak gameNode;
}
-(id) initWithGameNode:(MainGameLayer*)node InterfaceDelegate:(id<PlayerInterfaceDelegate>)interfaceDel;
-(void) spawn;
-(void) startShoot: (CGPoint) point;
-(void) moveShootPoint: (CGPoint) point;
-(void) endShoot;
-(bool)takeHit:(float)damage;
-(CGRect) hitBox;



@end
