//
//  PDFDocumentOutlineContainerViewController.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 4/7/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFDocumentOutlineViewController;
@class PDFDocumentBookmarkListViewController;

@interface PDFDocumentOutlineContainerViewController : UIViewController
@property (nonatomic, strong) PDFDocumentOutlineViewController *outlineViewController;
@property (nonatomic, strong) PDFDocumentBookmarkListViewController *bookmarkListViewController;
@property (nonatomic, strong) UIViewController *currentViewController;
@end
