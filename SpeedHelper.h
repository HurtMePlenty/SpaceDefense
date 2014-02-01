//
//  SpeedHelper.h
//  SpaceDefense
//
//  Created by Eliphas on 22.11.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#ifndef SpaceDefense_SpeedHelper_h
#define SpaceDefense_SpeedHelper_h
#import "cocos2d.h"

static float speedMultiplier = 1.0f;
static bool worldSpeedModified = NO;

static float getWorldSpeed(float speed){
    if(!worldSpeedModified)
    {
        return speed;
    }
    return speed * speedMultiplier;
}

static CGPoint getWorldVelocity(CGPoint point) {
    if(!worldSpeedModified)
    {
        return point;
    }
    return ccp(point.x * speedMultiplier, point.y * speedMultiplier);
}



#endif
