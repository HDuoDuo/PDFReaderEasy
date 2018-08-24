//
//  PDFDocumentInfoView.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/02/17.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFDocumentInfo;

@interface PDFDocumentInfoView : UIView
@property (nonatomic, strong) PDFDocumentInfo *info;
- (void)show;
- (void)hide;
- (void)showAndHide;
@end
