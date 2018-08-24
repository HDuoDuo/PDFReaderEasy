//
//  PDFDocumentBookmarkList.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2/24/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFDocument;

@interface PDFDocumentBookmarkList : NSObject
@property (nonatomic, strong, readonly) NSArray *bookmarkedSectionList;
@property (nonatomic, readonly) NSArray *bookmarkList;
@property (nonatomic, weak) PDFDocument *document;
- (void)bookmarkAtPage:(NSUInteger)page;
- (void)unbookmarkAtPage:(NSUInteger)page;
- (BOOL)bookmarkedAtPage:(NSUInteger)page;
- (void)toggleBookmarkAtPage:(NSUInteger)page;
@end
