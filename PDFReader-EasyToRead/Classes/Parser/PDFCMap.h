//
//  PDFCMap.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 3/8/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFCMap : NSObject
- (instancetype)initWithStream:(CGPDFStreamRef)stream;
- (unichar)unicodeFromCID:(char)cid;
- (char)CIDFromUnicode:(unichar)unicode;
- (BOOL)canConvertCID:(char)cid;
@end
