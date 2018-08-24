//
//  PDFDocumentInfo.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 2018/02/17.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "PDFDocumentInfo.h"

#import "PDFDocument.h"
#import "PDFDocumentOutline.h"

@interface PDFDocumentInfo ()
@property (nonatomic, strong) PDFDocument *document;
@end

@implementation PDFDocumentInfo

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"pageDescription"]) {
        return [NSSet setWithObjects:@"document.currentPage", nil];
    }
    return [NSSet set];
}
/**- (instancetype)initWithDocument:(PDFDocument *)document
 {
 self = [super init];
 if (self) {
 _document = document;
 }
 return self;
 }
 
 - (NSString *)pageDescription
 {
 return [NSString stringWithFormat:@"%d/%d",
 (int)self.document.currentPage,
 (int)self.document.numberOfPages];
 }
**/
- (instancetype)initWithDocument:(PDFDocument *)document
{
    self = [super init];
    if (self) {
        _document = document;
    }
    return self;
}

- (NSString *)pageDescription
{
    return [NSString stringWithFormat:@"%d/%d",
                     (int)self.document.currentPage,
                     (int)self.document.numberOfPages];
}

- (NSString *)sectionTitle
{
    return [self.document.outline sectionTitleAtIndex:self.document.currentPage];
}

- (NSString *)title
{
    return self.document.name;
}

@end
