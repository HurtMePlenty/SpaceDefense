//
//  BulletSimpleFactory.m
//  SpaceDefense
//
//  Created by Eliphas on 23.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import "BulletSimpleFactory.h"

static BulletSimpleFactory* instance;

@implementation BulletSimpleFactory

-(id)init{
    if(self = [super init])
    {
        //create some bullets here as initial.
    }
    instance = self;
    return self;
}

+(BulletSimpleFactory*) sharedInstance
{
    return instance;
}

+(void)killInstance{
    instance = nil;
}

-(BulletSimple*) createBullet{
    BulletSimple* bullet = [super.reusableObjects lastObject];
    if(bullet) {
        [[super reusableObjects] removeLastObject];
    } else {
        bullet = [[BulletSimple alloc] initWithPlayer:currentPlayer GameNode:gameNode];
    }
    bullet.responsibleFactory = self;
    [super.objectsInUse addObject:bullet];
    if(bullet.parent != nil)
    {
        CCLOG(@"SHIT HAPPENS");
    }
    return bullet;
}

@end
