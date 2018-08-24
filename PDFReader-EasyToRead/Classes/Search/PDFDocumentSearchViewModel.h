//
//  PDFDocumentSearchViewModel.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/9/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFDocumentOutline;
@class PDFDocumentSearch;
@class PDFDocumentSearchResult;

@interface PDFDocumentSearchViewModel : NSObject
- (instancetype)initWithSearch:(PDFDocumentSearch *)search
                       outline:(PDFDocumentOutline *)outline;
- (void)startSearchWithKeyword:(NSString *)keyword
                    foundBlock:(void (^)(NSUInteger, NSUInteger))foundBlock
               completionBlock:(void (^)(BOOL))completionBlock;
- (void)stopSearch;
- (PDFDocumentSearchResult *)resultAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong, readonly) NSArray *sections;
@property (nonatomic, readonly) BOOL searching;
@end

@interface PDFDocumentSearchViewSection : NSObject
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSArray *results;
@end
