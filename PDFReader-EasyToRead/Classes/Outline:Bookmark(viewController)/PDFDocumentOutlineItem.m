//
//  PDFDocumentOutlineItem.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "PDFDocumentOutlineItem.h"

@interface PDFDocumentOutlineItem ()
@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, assign, readwrite) NSUInteger pageNumber;
@property (nonatomic, assign, readwrite) CGPDFObjectRef destination;
@property (nonatomic, strong, readwrite) NSArray *children;
@end

@implementation PDFDocumentOutlineItem

- (instancetype)initWithTitle:(NSString *)title
                   pageNumber:(NSUInteger)pageNumber
                  destination:(CGPDFObjectRef)destination
                     children:(NSArray *)children
{
    self = [super init];
    if (self) {
        _title = title;
        _destination = destination;
        _pageNumber = pageNumber;
        _children = children;
    }
    return self;
}

#pragma mark -

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %d",
                     [super description],
                     self.title,
                     (int)self.pageNumber];
}

@end
