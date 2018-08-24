//
//  PDFDocumentPageSliderModel.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/12/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFDocument;

@interface PDFDocumentPageSliderModel : NSObject
- (instancetype)initWithDocument:(PDFDocument *)document;
@property (nonatomic, readonly) NSUInteger currentPage;
@property (nonatomic, readonly) NSUInteger numberOfPages;
@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;
@end
