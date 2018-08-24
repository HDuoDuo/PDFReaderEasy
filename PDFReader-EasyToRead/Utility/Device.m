//
//  Device.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 4/1/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "Device.h"

BOOL IsPad()
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

BOOL IsPhone()
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}
