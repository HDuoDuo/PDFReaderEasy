//
//  PDFDocumentBookmarkListViewController.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2/25/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFDocumentBookmarkList;

@interface PDFDocumentBookmarkListViewController : UITableViewController
@property (nonatomic, strong) PDFDocumentBookmarkList *bookmarkList;
@end
