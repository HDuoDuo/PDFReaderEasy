//
//  PDFDocumentOutlineItem.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFDocumentOutlineItem : NSObject
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, assign, readonly) NSUInteger pageNumber;
@property (nonatomic, assign, readonly) CGPDFObjectRef destination;
@property (nonatomic, strong, readonly) NSArray *children;
- (instancetype)initWithTitle:(NSString *)title
                   pageNumber:(NSUInteger)pageNumber
                  destination:(CGPDFObjectRef)destination
                     children:(NSArray *)children;
@end
