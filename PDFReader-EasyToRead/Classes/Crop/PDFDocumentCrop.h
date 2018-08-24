//
//  PDFDocumentCrop.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/21.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFPage;

typedef NS_ENUM(NSUInteger, PDFDocumentCropMode) {
    PDFDocumentCropModeNone,
    PDFDocumentCropModeSame,            
    PDFDocumentCropModeDifferent,
};

@interface PDFDocumentCrop : NSObject
@property (nonatomic, assign) CGRect oddCropRect;
@property (nonatomic, assign) CGRect evenCropRect;
@property (nonatomic, assign) PDFDocumentCropMode mode;
@property (nonatomic, readonly) BOOL enabled;
- (CGRect)cropRectAtPage:(NSUInteger)page;
@end
