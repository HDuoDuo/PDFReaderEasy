//
//  PDFDocumentOutline.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFDocumentOutlineItem;

@interface PDFDocumentOutline : NSObject
@property (nonatomic, strong, readonly) NSArray *items;
- (instancetype)initWithCGPDFDocument:(CGPDFDocumentRef)document;
- (NSString *)sectionTitleAtIndex:(NSUInteger)index;
@end
