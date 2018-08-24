//
//  NSString+PDFReaderAdditions.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 6/17/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "NSString+PDFReaderAdditions.h"

#import <CommonCrypto/CommonDigest.h>


@implementation NSString (PDFReaderAdditions)

- (NSString *)grt_md5
{
  const char *str = [self UTF8String];
  unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
  CC_MD5(str, (CC_LONG)strlen(str), md5Buffer);
  NSMutableString *md5 = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)  {
      [md5 appendFormat:@"%02x", md5Buffer[i]];
  }
  return md5;
}
/*- (NSString *)grt_md5
 {
 const char *str = [self UTF8String];
 unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
 CC_MD5(str, (CC_LONG)strlen(str), md5Buffer);
 NSMutableString *md5 = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
 for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)  {
 [md5 appendFormat:@"%02x", md5Buffer[i]];
 }
 return md5;
 }*/

@end
