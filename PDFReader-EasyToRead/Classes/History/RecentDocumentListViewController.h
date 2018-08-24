//
//  RecentDocumentListViewController.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/20/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecentDocumentListViewModel;

@interface RecentDocumentListViewController : UITableViewController
@property (nonatomic, strong) RecentDocumentListViewModel *viewModel;
@end
