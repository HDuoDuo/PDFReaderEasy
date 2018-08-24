//
//  LibraryUtils.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 3/30/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "LibraryUtils.h"

BOOL CrashlyticsEnabled()
{
    return GetCrashlyticsAPIKey().length > 0;
}

NSString * GetCrashlyticsAPIKey()
{
    NSString *path = [NSBundle.mainBundle pathForResource:@"API_KEY"
                                                   ofType:@"plist"];
    NSDictionary *keys = [NSDictionary dictionaryWithContentsOfFile:path];
    return keys[@"CRASHLYTICS_API_KEY1"];
}
