//
//  PDFDocumentSearchResult.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/7/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFDocumentSearchResult : NSObject
+ (PDFDocumentSearchResult *)resultWithSurroundingText:(NSString *)surroundingText
                                                 range:(NSRange)range
                                                atPage:(NSUInteger)page;
@property (nonatomic, assign, readonly) NSUInteger page;
@property (nonatomic, assign, readonly) NSRange range;
@property (nonatomic, copy, readonly) NSString *surroundingText;
@end


@interface PDFDocumentSearchResult (TableViewCellAdditions)
@property (nonatomic, readonly) NSAttributedString *attributedDescription;
@end

