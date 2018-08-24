//
//  PDFText.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 3/2/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "PDFText.h"

#import "PDFTextState.h"

@implementation PDFText

- (instancetype)initWithText:(NSString *)text
                       state:(PDFTextState *)state
{
    self = [super init];
    if (self) {
        _text = text;
        _state = state;
    }
    return self;
}

@end
