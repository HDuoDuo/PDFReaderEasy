//
//  PDFRecentDocumentList.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/02/06.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFDocument;
@class PDFDocumentStore;

@interface PDFRecentDocumentList : NSObject
@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, strong, readonly) NSArray *documents;
@property (nonatomic, weak, readonly) PDFDocumentStore *store;
- (instancetype)initWithStore:(PDFDocumentStore *)store;
- (PDFDocument *)documentAtIndex:(NSUInteger)index;
- (void)addHistory:(PDFDocument *)document;
- (PDFDocument *)findDocumentAtPath:(NSString *)path;
- (void)removeHistories:(NSArray *)histories;
@end
