//
//  PDFPageScanner.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 3/2/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFPageScanner : NSObject
@property (nonatomic, assign) CGPDFPageRef CGPDFPage;
- (instancetype)initWithCGPDFPage:(CGPDFPageRef)CGPDFPage;
- (NSArray *)scanStringContents;
- (NSArray *)scanAnchors;
@end
