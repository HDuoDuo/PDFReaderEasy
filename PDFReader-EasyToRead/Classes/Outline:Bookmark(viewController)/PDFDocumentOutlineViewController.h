//
//  PDFDocumentOutlineViewController.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/20.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFDocumentOutline;

@interface PDFDocumentOutlineViewController : UITableViewController
@property (nonatomic, strong) PDFDocumentOutline *outline;
@property (nonatomic, assign) NSUInteger currentPage;
@end
