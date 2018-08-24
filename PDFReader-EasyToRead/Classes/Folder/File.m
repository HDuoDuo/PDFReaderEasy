//
//  File.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/17.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "File.h"

@implementation File

- (instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    if (self) {
        _path = path;
    }
    return self;
}

- (NSString *)name
{
    return self.path.lastPathComponent;
}

@end
