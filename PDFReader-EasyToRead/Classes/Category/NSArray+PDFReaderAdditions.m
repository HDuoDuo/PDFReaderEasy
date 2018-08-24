//
//  NSArray+PDFReaderAdditions.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "NSArray+PDFReaderAdditions.h"

@implementation NSArray (PDFReaderAdditions)

- (NSArray *)grt_map:(id (^)(id))block
{
    NSMutableArray *newArray = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id item, NSUInteger index, BOOL *stop) {
        id obj = block(item);
        if (obj) {
            [newArray addObject:obj];
        }
    }];
    return newArray;
}
- (NSArray *)grt_maps:(id (^)(id))block
{
    NSMutableArray *newArray = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id item, NSUInteger index, BOOL *stop) {
        id obj = block(item);
        if (obj) {
            [newArray addObject:obj];
        }
    }];
    return newArray;
}
- (NSArray *)grt_filter:(BOOL (^)(id))block
{
    NSMutableArray *newArray = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id item, NSUInteger index, BOOL *stop) {
        if (block(item)) {
            [newArray addObject:item];
        }
    }];
    return newArray;
}
- (NSArray *)grt_filters:(BOOL (^)(id))block
{
    NSMutableArray *newArray = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id item, NSUInteger index, BOOL *stop) {
        if (block(item)) {
            [newArray addObject:item];
        }
    }];
    return newArray;
}
@end
