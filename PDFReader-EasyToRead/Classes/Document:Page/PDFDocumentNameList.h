//
//  PDFDocumentNameList.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 8/5/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFDocumentNameList : NSObject
- (instancetype)initWithCGPDFDocument:(CGPDFDocumentRef)document;
- (NSUInteger)pageNumberForName:(NSString *)name;
@end
