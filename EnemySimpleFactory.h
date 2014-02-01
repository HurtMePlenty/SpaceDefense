//
//  EnemySimpleFactory.h
//  SpaceDefense
//
//  Created by Eliphas on 12.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnemySimple.h"
#import "GameObjectFactory.h"


@interface EnemySimpleFactory : GameObjectFactory

+(EnemySimpleFactory*) sharedInstance;
-(EnemySimple*) createPirate;


@end
