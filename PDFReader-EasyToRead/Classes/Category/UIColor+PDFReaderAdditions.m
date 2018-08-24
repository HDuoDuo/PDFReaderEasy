//
//  UIColor+PDFReaderAdditions.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 4/14/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "UIColor+PDFReaderAdditions.h"

@implementation UIColor (PDFReaderAdditions)

+ (UIColor *)grt_defaultTintColor
{
    static dispatch_once_t onceToken;
    static UIColor *tintColor = nil;
    dispatch_once(&onceToken, ^{
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        tintColor = toolbar.tintColor;
    });
    return tintColor;
}

+ (UIColor *)grt_defaultBlackTintColor
{
    static dispatch_once_t onceToken;
    static UIColor *bTintColor = nil;
    dispatch_once(&onceToken, ^{
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        toolbar.barStyle = UIBarStyleBlack;
        bTintColor = toolbar.tintColor;
    });
    return bTintColor;    
}
+ (UIColor *)grt_defaultBlackTintColors
{
    static dispatch_once_t onceToken;
    static UIColor *bTintColor = nil;
    dispatch_once(&onceToken, ^{
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        toolbar.barStyle = UIBarStyleBlack;
        bTintColor = toolbar.tintColor;
    });
    return bTintColor;
}
@end
