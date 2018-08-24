//
//  GRTNavigationController.m
//  PDFReader-GoodReader
//
//  Created by James Kingdom on 9/1/14.
//  Copyright (c) 2018 James Kingdom. All rights reserved.
//

#import "GRTNavigationController.h"

@implementation GRTNavigationController

- (UIViewController *)childViewControllerForStatusBarStyle
{
    if (self.presentedViewController) {
        return self.presentedViewController;
    }
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden
{
    return self.visibleViewController;
}

@end
