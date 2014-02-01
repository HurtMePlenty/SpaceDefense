//
//  EnemySimpleFactory.m
//  SpaceDefense
//
//  Created by Eliphas on 12.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import "EnemySimpleFactory.h"

static EnemySimpleFactory* instance;

@interface EnemySimpleFactory()


@end

@implementation EnemySimpleFactory

-(id)init{
    if(self = [super init])
    {
        //create some objects here as initial.
    }
    instance = self;
    return self;
}

+(EnemySimpleFactory*) sharedInstance
{
    return instance;
}



-(EnemySimple*) createEnemy {
    EnemySimple* enemy = [super.reusableObjects lastObject];
    if(enemy) {
        [[super reusableObjects] removeLastObject];
    } else {
        enemy = [[EnemySimple alloc] initWithPlayer:currentPlayer GameNode:gameNode];
    }
    enemy.responsibleFactory = self;
    [super.objectsInUse addObject:enemy];
    return enemy;
}

-(EnemySimple*) createPirate {
    EnemySimple* pirate = [self createEnemy];
    [pirate buildWithType:PIRATE Health: 2];
    return pirate;
}


@end
