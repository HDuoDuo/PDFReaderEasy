//
//  FolderDocumentListViewModel.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 5/23/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "DocumentListViewModel.h"

@class Folder;

@interface FolderDocumentListViewModel : DocumentListViewModel
- (instancetype)initWithFolder:(Folder *)folder;
@property (nonatomic, strong, readonly) Folder *folder;
@end
