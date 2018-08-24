//
//  PDFDocumentInfo.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/02/17.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFDocument;

@interface PDFDocumentInfo : NSObject
- (instancetype)initWithDocument:(PDFDocument *)document;
@property (nonatomic, readonly) NSString *pageDescription;
@property (nonatomic, readonly) NSString *sectionTitle;
@property (nonatomic, readonly) NSString *title;
@end
