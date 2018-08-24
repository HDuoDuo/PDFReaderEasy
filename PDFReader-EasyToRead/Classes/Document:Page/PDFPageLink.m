//
//  PDFPageLink.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/30/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "PDFPageLink.h"

@interface PDFPageLink ()
@property (nonatomic, readwrite, assign) NSUInteger pageNumber;
@property (nonatomic, readwrite, assign) CGRect rect;
@end

@implementation PDFPageLink

- (instancetype)initWithPageNumber:(NSUInteger)pageNumber
                               rect:(CGRect)rect
{
    self = [super init];
    if (self) {
        _pageNumber = pageNumber;
        _rect = rect;
    }
    return self;
}

@end
