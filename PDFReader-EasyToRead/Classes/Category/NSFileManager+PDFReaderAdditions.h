//
//  NSFileManager+PDFReaderAdditions.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/02/10.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (PDFReaderAdditions)
+ (NSString *)grt_privateDocumentsPath;
+ (NSString *)grt_documentsPath;
+ (NSString *)grt_libraryPath;
+ (NSString *)grt_cachePath;
- (void)grt_createPrivateDocumentsDirectory;
- (NSURL *)grt_incrementURLIfNecessary:(NSURL *)URL;
@end
