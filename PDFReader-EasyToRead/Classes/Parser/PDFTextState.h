//
//  PDFTextState.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 3/2/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFFont;

@interface PDFTextState : NSObject
@property (nonatomic, assign) CGFloat leading;
@property (nonatomic, assign) CGFloat characterSpace;
@property (nonatomic, assign) CGFloat wordSpace;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGAffineTransform textMatrix;
@property (nonatomic, assign) CGAffineTransform textLineMatrix;
@property (nonatomic, assign) CGAffineTransform ctm;
@property (nonatomic, strong) PDFFont *font;

@property (nonatomic, readonly) CGAffineTransform transform;

- (void)moveLine:(CGSize)offset;
- (void)move:(CGSize)offset;
@end
