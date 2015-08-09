//
//  UIViewController+SCSliderMenu.m
//  SCSliderViewController
//
//  Created by Sunc on 15/8/7.
//  Copyright (c) 2015年 Sunc. All rights reserved.
//

#import "UIViewController+SCSliderMenu.h"
#import "SliderMenu.h"

@implementation UIViewController (SCSliderMenu)

- (SliderMenu *)sliderMenuViewController
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[SliderMenu class]]) {
            return (SliderMenu *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

- (void)showLeftMenu:(id)sender{
    [self.sliderMenuViewController showLeftMenuViewController];
}

- (void)showRightMenu:(id)sender{
    [self.sliderMenuViewController showRightMenuViewController];
}


@end
