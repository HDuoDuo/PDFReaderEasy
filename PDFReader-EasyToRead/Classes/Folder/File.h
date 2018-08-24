//
//  File.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/01/17.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface File : NSObject
@property (nonatomic, readonly) NSString *path;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, assign) BOOL fileNotExist;
- (instancetype)initWithPath:(NSString *)path;
@end
