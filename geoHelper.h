//
//  geoHelper.h
//  SpaceDefense
//
//  Created by Eliphas on 24.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import "cocos2d.h"

#ifndef SpaceDefense_geoHelper_h
#define SpaceDefense_geoHelper_h

static inline BOOL isOutOfNode(CCNode* node, CGPoint point){
    return node.boundingBox.size.width < point.x || point.x < 0 || node.boundingBox.size.height < point.y || point.y < 0;
}

#endif
