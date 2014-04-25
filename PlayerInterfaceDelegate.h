//
//  PlayerInterfaceDelegate.h
//  SpaceDefense
//
//  Created by Eliphas on 02.02.14.
//  Copyright (c) 2014 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PlayerInterfaceDelegate <NSObject>

-(void) setHealth:(float) health;
-(void) addMoney: (float) money;
-(void) playerDied;

@end
