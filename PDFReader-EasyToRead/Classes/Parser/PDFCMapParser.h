//
//  PDFCMapParser.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 3/8/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFCMapParser;

@protocol PDFCMapParserDelegate <NSObject>
- (void)parser:(PDFCMapParser *)parser
foundCodeSpaceRange:(NSRange)range;
- (void)parser:(PDFCMapParser *)parser
  foundMapping:(NSDictionary *)mapping;
@end

@interface PDFCMapParser : NSObject
- (instancetype)initWithStream:(CGPDFStreamRef)stream;
- (void)parse;
@property (nonatomic, weak) id<PDFCMapParserDelegate> delegate;
@end
