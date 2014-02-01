//
//  TextureExtractor.m
//  SpaceDefense
//
//  Created by Eliphas on 13.10.13.
//  Copyright (c) 2013 Eliphas. All rights reserved.
//

#import "TextureExtractor.h"

@implementation TextureExtractor

+(TextureExtractor*) instance {
    static TextureExtractor* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once( &predicate, ^{
        instance = [ [ self alloc ] init ];
    } );
    return instance;
}

- (id) init {
    if( (self=[super init])) {
        
	}
	return self;
}

- (CCTexture2D*) getTextureByName:(NSString*)name {
    return [[CCTextureCache sharedTextureCache] addImage:name];
}


@end
