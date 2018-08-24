//
//  FolderDocumentListViewModel.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 5/23/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "FolderDocumentListViewModel.h"

#import "Folder.h"
#import "PDFDocument.h"
#import "PDFDocumentStore.h"
#import "PDFRecentDocumentList.h"

@interface FolderDocumentListViewModel ()
@property (nonatomic, strong, readwrite) Folder *folder;
@end

@implementation FolderDocumentListViewModel

- (instancetype)initWithFolder:(Folder *)folder
{
    self = [super init];
    if (self) {
        _folder = folder;
    }
    return self;
}

- (NSString *)title
{
    return LocalizedString(@"home.all-documents");
}

- (NSUInteger)count
{
    return self.folder.files.count;
}

- (PDFDocument *)documentAtIndex:(NSUInteger)index
{
    return self.folder.files[index];
}

- (void)reload
{
    [self.folder load];
}

- (void)deleteDocuments:(NSArray *)documents
{
    [self.folder.store deleteDocuments:documents];
}

@end
