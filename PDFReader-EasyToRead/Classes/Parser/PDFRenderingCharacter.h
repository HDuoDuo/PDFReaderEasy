//
//  PDFRenderingCharacter.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 3/10/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFTextState;

@interface PDFRenderingCharacter : NSObject
@property (nonatomic, assign) unichar c;
@property (nonatomic, strong) PDFTextState *state;
@property (nonatomic, readonly) CGRect frame;
@property (nonatomic, readonly) NSString *stringDescription;
- (instancetype)initWithCharacter:(unichar)c
                            state:(PDFTextState *)state;
- (BOOL)isNotWordCharater;
- (BOOL)isSameLineAs:(PDFRenderingCharacter *)character;
@end
