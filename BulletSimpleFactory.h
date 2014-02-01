//
//  BulletSimpleFactory.h
//  SpaceDefense
//
//  Created by Eliphas on 23.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObjectFactory.h"
#import "BulletSimple.h"

@interface BulletSimpleFactory : GameObjectFactory

-(BulletSimple*) createBullet;
+(BulletSimpleFactory*) sharedInstance;
+(void)killInstance;

@end
