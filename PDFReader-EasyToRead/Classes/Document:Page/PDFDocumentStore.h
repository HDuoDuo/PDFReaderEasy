//
//  PDFDocumentStore.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 5/29/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFDocument;
@class PDFRecentDocumentList;
@class RootFolder;

@interface PDFDocumentStore : NSObject
@property (nonatomic, strong, readonly) PDFRecentDocumentList *documentList;
@property (nonatomic, strong, readonly) RootFolder *rootFolder;
- (PDFDocument *)documentAtPath:(NSString *)path;
- (void)addHistory:(PDFDocument *)document;
- (void)deleteDocuments:(NSArray *)documents;
- (void)deleteDocument:(PDFDocument *)document;
@end
