//
//  DocumentTableViewCell.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/6/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DocumentCell.h"

@class PDFDocument;

@interface DocumentTableViewCell : UITableViewCell <DocumentCell>
@property (nonatomic, strong) PDFDocument *document;
@end
