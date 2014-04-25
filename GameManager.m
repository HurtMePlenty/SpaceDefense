//
//  WaveConstructor.m
//  SpaceDefense
//
//  Created by Eliphas on 15.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import "GameManager.h"
#import "EnemySimpleFactory.h"
#import "BulletSimpleFactory.h"

@interface GameManager(){
    int level;
    MainGameLayer* gameNode;
    CCNode* uiNode;
    Player* player;
    CGSize gameNodeSize;
    EnemySimpleFactory* esFactory;
   
    int enemySimpleWaveAmount;
    int enemyTotalWave;
    int currentEnemyAmount;
    
    NSMutableArray* enemies;
}

@end

@implementation GameManager

-(id) init {
    if( (self=[super init])) {
        
	}
	return self;
}

-(id) initWithGameNode:(MainGameLayer*)node UINode:(CCNode *)interfaceNode {
    self = [self init];
    if(self){
        gameNode = node;
        gameNode.playerInputDelegate = self;
        uiNode = interfaceNode;
        gameNodeSize = node.contentSize;
        enemies = [NSMutableArray arrayWithCapacity:250];
        [self createPlayer];
        [self createFactories];
        [self startLevel];
    }
    return self;
}

-(void) createWave:(ccTime)delta {
    CCLOG(@"creating Wave");
    currentEnemyAmount = 0;
    enemySimpleWaveAmount = 3; // CCRANDOM_0_1() * 90 + 2;
    enemyTotalWave = enemySimpleWaveAmount;
    
    [self startSpawnNext];
    [self unschedule:_cmd];
 }

-(void) startSpawnNext {
    if(currentEnemyAmount < enemyTotalWave)
    {
        [self schedule:@selector(createEnemy:) interval:0.7f];
    }
    else
    {
        [self scheduleWave:7.0f];
    }
}

-(void) createEnemy:(ccTime)delta {
    SimpleGameObject* enemy;
    int totalEnemyCount = enemySimpleWaveAmount;
    int rnd = CCRANDOM_0_1() * totalEnemyCount;
    if(rnd >= 0 && rnd < enemySimpleWaveAmount)
    {
        enemy = [esFactory createPirate];
    }
    
    float spawnX = gameNodeSize.width + enemy.contentSize.width / 2;
    float spawnY = CCRANDOM_0_1() * (gameNodeSize.height - enemy.contentSize.height) + enemy.contentSize.height / 2;
    
    [enemy spawnAtPoint:ccp(spawnX, spawnY)];
    [enemy activate];
    
    
    [enemies addObject:enemy];
    currentEnemyAmount++;
    [self unschedule:_cmd];
    [self startSpawnNext];
}

-(void) scheduleWave:(float)delay{
    [self schedule:@selector(createWave:) interval:delay];
}


-(void) startLevel {
    [self scheduleWave:3.0f];
}

-(void) createFactories {
    esFactory = [[EnemySimpleFactory alloc] initWithPlayer:player GameNode:gameNode];
}


-(void) createPlayer{
    player = [[Player alloc] initWithGameNode:gameNode InterfaceDelegate:self];
    [player spawn];
}

-(void)playerMoveShootPoint:(CGPoint)point {
    [player moveShootPoint:point];
}

-(void) playerStartShootPoint:(CGPoint)point{
    [player startShoot:point];
}

-(void) playerEndShoot {
    [player endShoot];
}

-(void)dealloc{
    [BulletSimpleFactory killInstance];
}

-(void)playerDied {
    CCLabelTTF* label = [CCLabelTTF labelWithString:@"You lost" fontName:@"Helvetica-BoldOblique" fontSize:18 ];
    label.position = ccp(gameNode.contentSize.width / 2, gameNode.contentSize.height / 2);
    [gameNode addChild:label];
}


@end
