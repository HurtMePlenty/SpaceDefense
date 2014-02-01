//
//  PlayerInputDelegate.h
//  SpaceDefense
//
//  Created by Eliphas on 23.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PlayerInputDelegate <NSObject>

-(void) playerStartShootPoint:(CGPoint) point;
-(void) playerMoveShootPoint:(CGPoint) point;
-(void) playerEndShoot;

@end
