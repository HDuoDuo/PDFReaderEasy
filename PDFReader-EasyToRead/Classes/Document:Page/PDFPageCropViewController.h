//
//  PDFPageCropViewController.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/21.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "PDFPageViewController.h"

@class PDFDocumentCrop;

@interface PDFPageCropViewController : PDFPageViewController
@property (nonatomic, strong) PDFDocumentCrop *crop;
@property (nonatomic, readonly) CGRect cropRect;
@end
