//
//  PDFDocumentCropViewController.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/21.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFDocument;
@class PDFDocumentCrop;

@interface PDFDocumentCropViewController : UIViewController
@property (nonatomic, strong) PDFDocumentCrop *crop;
@property (nonatomic, strong) PDFDocument *document;
@property (nonatomic, assign) BOOL even;
@end

@interface PDFDocumentCropLayoutView : UIView
@end
