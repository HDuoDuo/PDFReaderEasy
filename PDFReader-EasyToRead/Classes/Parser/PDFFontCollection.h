//
//  PDFFontCollection.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 3/5/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFFont;

@interface PDFFontCollection : NSObject
- (instancetype)initWithCGPDFPage:(CGPDFPageRef)CGPDFPage;
- (PDFFont *)fontForName:(NSString *)name;
@end
