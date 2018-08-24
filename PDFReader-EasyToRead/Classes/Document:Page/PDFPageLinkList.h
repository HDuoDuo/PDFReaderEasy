//
//  PDFPageLinkList.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/29/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFDocumentNameList;
@class PDFPageLink;

@interface PDFPageLinkList : NSObject
- (instancetype)initWithCGPDFPage:(CGPDFPageRef)cgPage
                         nameList:(PDFDocumentNameList *)nameList;
@property (nonatomic, readonly) NSArray *links;
@end
