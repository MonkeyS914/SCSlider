//
//  UIViewController+SCSliderMenu.h
//  SCSliderViewController
//
//  Created by Sunc on 15/8/7.
//  Copyright (c) 2015年 Sunc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderMenu.h"

@class SliderMenu;

@interface UIViewController (SCSliderMenu)

@property (strong, readonly, nonatomic) SliderMenu *sliderMenuViewController;

- (void)showLeftMenu:(id)sender;

- (void)showRightMenu:(id)sender;

@end
