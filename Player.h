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


@interface Player : CCNode {
    MainGameLayer* __weak gameNode;
}
@property (nonatomic) float rightBorder;
-(id) initWithGameNode:(MainGameLayer*)node;
-(void) spawn;
-(void) startShoot: (CGPoint) point;
-(void) moveShootPoint: (CGPoint) point;
-(void) endShoot;



@end
