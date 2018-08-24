//
//  PDFDocumentSearchViewController.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/9/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFDocumentSearchViewModel;

@interface PDFDocumentSearchViewController : UITableViewController
@property (nonatomic, strong) PDFDocumentSearchViewModel *viewModel;
@end
