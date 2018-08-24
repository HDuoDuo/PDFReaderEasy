//
//  DocumentModalTransitionAnimator.h
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 7/19/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentModalTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL presenting;
@end
