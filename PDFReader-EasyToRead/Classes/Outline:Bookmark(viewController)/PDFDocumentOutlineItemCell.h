//
//  PDFDocumentOutlineItemCell.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/20.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFDocumentOutlineItem;

@interface PDFDocumentOutlineItemCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *pageNumberLabel;
@property (nonatomic, strong) IBOutlet UIView *currentLine;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *leftMarginConstraint;
+ (CGFloat)cellHeightForItem:(PDFDocumentOutlineItem *)item
                       level:(NSUInteger)level;
- (void)configureWithItem:(PDFDocumentOutlineItem *)item
                    level:(NSUInteger)level
                  current:(BOOL)current;
@end
