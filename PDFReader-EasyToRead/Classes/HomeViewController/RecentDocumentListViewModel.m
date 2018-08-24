//
//  RecentDocumentListViewModel.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 5/23/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "RecentDocumentListViewModel.h"

#import "PDFDocument.h"
#import "PDFDocumentStore.h"
#import "PDFRecentDocumentList.h"

@interface RecentDocumentListViewModel ()
@property (nonatomic, strong) PDFRecentDocumentList *documentList;
@end

@implementation RecentDocumentListViewModel

- (instancetype)initWithDocumentList:(PDFRecentDocumentList *)documentList
{
    self = [super init];
    if (self) {
        _documentList = documentList;
    }
    return self;
}

- (NSString *)title
{
    return LocalizedString(@"home.recently-read");
}

- (NSUInteger)count
{
    return self.documentList.count;
}

- (PDFDocument *)documentAtIndex:(NSUInteger)index
{
    return [self.documentList documentAtIndex:index];
}

- (void)deleteDocuments:(NSArray *)documents
{
    [self.documentList.store deleteDocuments:documents];
}

- (void)removeDocumentHistories:(NSArray *)documents
{
    [self.documentList removeHistories:documents];
}

@end
