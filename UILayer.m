//
//  UILayer.m
//  SpaceDefense
//
//  Created by Eliphas on 18.10.13.
//  Copyright 2013 Eliphas. All rights reserved.
//

#import "UILayer.h"

@interface UILayer(){
    
}

@end

@implementation UILayer

-(id)init{
    if(self = [super init])
    {
        [self createTopLabels];
    }
    return self;
}

-(void) createTopLabels {
    CCLabelTTF* moneyLbl = [CCLabelTTF labelWithString:@"Money" fontName:@"Helvetica-BoldOblique" fontSize:12];
    moneyLbl.position = ccp(self.contentSize.width / 2, self.contentSize.height - moneyLbl.contentSize.height);
    moneyLbl.anchorPoint = ccp(0,0);
    [self addChild:moneyLbl];
}

@end
