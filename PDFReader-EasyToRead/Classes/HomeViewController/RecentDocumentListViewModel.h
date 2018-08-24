//
//  RecentDocumentListViewModel.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 5/23/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "DocumentListViewModel.h"

@class PDFRecentDocumentList;

@interface RecentDocumentListViewModel : DocumentListViewModel
- (instancetype)initWithDocumentList:(PDFRecentDocumentList *)documentList;
@end
