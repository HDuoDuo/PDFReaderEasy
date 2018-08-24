//
//  NSArray+PDFReaderAdditions.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (PDFReaderAdditions)
- (NSArray *)grt_map:(id (^)(id))block;
- (NSArray *)grt_filter:(BOOL (^)(id))block;
@end
