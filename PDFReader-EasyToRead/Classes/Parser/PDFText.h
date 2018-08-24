//
//  PDFText.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 3/2/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFTextState;

@interface PDFText : NSObject
- (instancetype)initWithText:(NSString *)text
                       state:(PDFTextState *)state;
@property (nonatomic, strong) PDFTextState *state;
@property (nonatomic, copy) NSString *text;
@end
