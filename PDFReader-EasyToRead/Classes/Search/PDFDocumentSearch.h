//
//  PDFDocumentSearch.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/7/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFDocument;
@class PDFDocumentSearch;
@class PDFDocumentSearchResult;

@protocol PDFDocumentSearchDelegate <NSObject>
- (void)search:(PDFDocumentSearch *)search
 didFindString:(PDFDocumentSearchResult *)result;
@end

@interface PDFDocumentSearch : NSObject
- (instancetype)initWithDocument:(PDFDocument *)document;
@property (nonatomic, weak, readonly) PDFDocument *document;
@property (nonatomic, weak) id<PDFDocumentSearchDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL searching;
- (void)searchWithString:(NSString *)keyword;
- (void)cancelSearch;
@end
