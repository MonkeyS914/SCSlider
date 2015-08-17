//
//  SliderMenu.h
//  SCSliderViewController
//
//  Created by Sunc on 15/8/7.
//  Copyright (c) 2015年 Sunc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SCSliderMenu.h"

@protocol SliderMenuDelegate;

@interface SliderMenu : UIViewController<UIGestureRecognizerDelegate>

@property (weak, readwrite, nonatomic) id<SliderMenuDelegate> delegate;

@property (strong, readwrite, nonatomic) UIViewController *contentViewController;
@property (strong, readwrite, nonatomic) UIViewController *leftMenuViewController;
@property (strong, readwrite, nonatomic) UIViewController *rightMenuViewController;

@property (strong, readwrite, nonatomic) UIImage *backgroundImage;

@property (assign, readwrite, nonatomic) CGFloat contentViewScaleValue;
@property (assign, readwrite, nonatomic) CGFloat contentViewCenterPoint;
@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;

@property (assign, readwrite, nonatomic) BOOL leftMenuIsShow;
@property (assign, readwrite, nonatomic) BOOL rightMenuIsShow;
@property (assign, readwrite, nonatomic) BOOL scaleContentView;
@property (assign, readwrite, nonatomic) BOOL enableGesture;
@property (assign, readwrite, nonatomic) BOOL interactivePopGestureRecognizerEnabled;
@property (assign, readwrite, nonatomic) BOOL panFromEdge;
@property (assign, readwrite, nonatomic) BOOL fadeMenuView;
@property (assign, readwrite, nonatomic) BOOL scaleBackgroundImageView;
@property (assign, readwrite, nonatomic) BOOL isFromRight;
@property (assign, readwrite, nonatomic) BOOL isFromLeft;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

- (id)initWithContentViewController:(UIViewController *)contentViewController
             leftMenuViewController:(UIViewController *)leftMenuViewController
            rightMenuViewController:(UIViewController *)rightMenuViewController;
- (void)showLeftMenuViewController;
- (void)showRightMenuViewController;
- (void)hideMenuViewController;
- (void)setContentViewController:(UIViewController *)contentViewController animated:(BOOL)animated;

@end

@protocol SliderMenuDelegate <NSObject>

@optional
- (void)sideMenu:(SliderMenu *)sideMenu didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer;
- (void)sideMenu:(SliderMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController;
- (void)sideMenu:(SliderMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController;
- (void)sideMenu:(SliderMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController;
- (void)sideMenu:(SliderMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController;

@end
