//
//  DocumentListTableViewController.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/5/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DocumentListViewController.h"

@interface DocumentListTableViewController : DocumentListViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end
