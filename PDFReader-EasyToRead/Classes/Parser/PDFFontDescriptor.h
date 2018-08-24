//
//  PDFFontDescriptor.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 3/11/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFFontDescriptor : NSObject
- (instancetype)initWithFontDescriptorDictionary:(CGPDFDictionaryRef)dictionary;
- (instancetype)initWithBaseFont:(NSString *)baseFont;
@property (nonatomic, assign, readonly) CGFloat descent;
@property (nonatomic, assign, readonly) CGFloat ascent;
@end
