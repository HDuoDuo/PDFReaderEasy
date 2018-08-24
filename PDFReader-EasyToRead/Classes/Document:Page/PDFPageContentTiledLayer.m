//
//  PDFPageContentTiledLayer.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/12.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "PDFPageContentTiledLayer.h"

@implementation PDFPageContentTiledLayer

+ (CFTimeInterval)fadeDuration
{
    return 0.001;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.levelsOfDetail = 16;
        self.levelsOfDetailBias = 16 - 1;
        self.tileSize = CGSizeMake(4096, 4096);
    }
    return self;
}

@end
