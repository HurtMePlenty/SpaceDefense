//
//  TextureExtractor.h
//  SpaceDefense
//
//  Created by Eliphas on 13.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TextureExtractor : NSObject

+(TextureExtractor*) instance;
- (CCTexture2D*) getTextureByName:(NSString*)name;

@end
