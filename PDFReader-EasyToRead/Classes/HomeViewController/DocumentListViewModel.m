//
//  DocumentListViewModel.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 5/23/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "DocumentListViewModel.h"

@implementation DocumentListViewModel
- (NSString *)title { return nil; }
- (NSUInteger)count { return 0; }
- (PDFDocument *)documentAtIndex:(NSUInteger)index { return nil; }
- (void)reload {}
- (void)deleteDocuments:(NSArray *)documents {}
- (void)removeDocumentHistories:(NSArray *)documents {}
@end
