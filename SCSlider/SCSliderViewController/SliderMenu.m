
//
//  SliderMenu.m
//  SCSliderViewController
//
//  Created by Sunc on 15/8/7.
//  Copyright (c) 2015年 Sunc. All rights reserved.
//

#import "SliderMenu.h"

#define IF_IOS7_OR_GREATER(...) \

@interface SliderMenu ()

@property (strong, readwrite, nonatomic) UIView *menuViewContainer;
@property (strong, readwrite, nonatomic) UIView *contentViewContainer;
@property (strong, readwrite, nonatomic) UIImageView *backgroundImageView;
@property (assign, readwrite, nonatomic) BOOL visible;
@property (assign, readwrite, nonatomic) BOOL leftMenuVisible;
@property (assign, readwrite, nonatomic) BOOL rightMenuVisible;


@end

@implementation SliderMenu
@synthesize leftSwipeGestureRecognizer;
@synthesize rightSwipeGestureRecognizer;

- (id)init
{
    self = [super init];
    if (self) {
        [self parameterInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self parameterInit];
    }
    return self;
}

- (void)parameterInit{
    //
    
    _menuViewContainer = [[UIView alloc] init];
    _contentViewContainer = [[UIView alloc] init];
    _enableGesture = YES;
    
    _contentViewScaleValue = 0.8f;
    _contentViewCenterPoint = 0.7f;
//    _animationDuration = 0.4f;
    _scaleContentView = YES;
//    _enableGesture = YES;
    _fadeMenuView = YES;
    _scaleBackgroundImageView = YES;
}

- (id)initWithContentViewController:(UIViewController *)contentViewController
             leftMenuViewController:(UIViewController *)leftMenuViewController
            rightMenuViewController:(UIViewController *)rightMenuViewController
{
    self = [self init];
    if (self) {
        _contentViewController = contentViewController;
        _leftMenuViewController = leftMenuViewController;
        _rightMenuViewController = rightMenuViewController;
    }
    return self;
}

- (void)presentLeftMenuViewController
{
    [self presentMenuViewContainerWithMenuViewController:self.leftMenuViewController];
    [self showLeftMenuViewController];
}

- (void)presentRightMenuViewController
{
    [self presentMenuViewContainerWithMenuViewController:self.rightMenuViewController];
    [self showRightMenuViewController];
}

- (void)presentMenuViewContainerWithMenuViewController:(UIViewController *)menuViewController
{
    if ([self.delegate conformsToProtocol:@protocol(SliderMenuDelegate)] && [self.delegate respondsToSelector:@selector(sideMenu:willShowMenuViewController:)]) {
        [self.delegate sideMenu:self willShowMenuViewController:menuViewController];
    }
}

- (void)showLeftMenuViewController
{
    //
    [self presentMenuViewContainerWithMenuViewController:self.leftMenuViewController];
    
    if (!self.leftMenuViewController) {
        return;
    }
    
    if (_leftMenuIsShow) {
        
        [self.leftMenuViewController beginAppearanceTransition:YES animated:YES];
        
        [UIView animateWithDuration:self.animationDuration animations:^{
            
            self.menuViewContainer.alpha = 0;
            self.contentViewController.view.alpha = 1;
            
            self.contentViewContainer.transform = CGAffineTransformIdentity;
            self.contentViewContainer.frame = self.view.bounds;
            
            self.backgroundImageView.transform = CGAffineTransformMakeScale(1.7f, 1.7f);
        
        }completion:^(BOOL finished) {
            [self.leftMenuViewController endAppearanceTransition];
            self.leftMenuViewController.view.hidden = YES;
        }];
        
        [self hideMenuViewController];
        
        return;
    }
    
    [self.leftMenuViewController beginAppearanceTransition:YES animated:YES];
    self.leftMenuViewController.view.hidden = NO;
    self.rightMenuViewController.view.hidden = YES;
    [self.view.window endEditing:YES];
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        if (self.scaleContentView) {
            //设置homeview的缩放倍数
            self.contentViewContainer.transform = CGAffineTransformMakeScale(1, 1);
        } else {
            self.contentViewContainer.transform = CGAffineTransformIdentity;
        }
        
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
            //设置homeview的位置
            self.contentViewContainer.center = CGPointMake(self.view.frame.size.width*4/5, self.view.frame.size.height/2);
            
        } else {
            self.contentViewContainer.center = CGPointMake(self.view.frame.size.width*4/5, self.view.frame.size.height/2);
        }
        self.menuViewContainer.alpha = !self.fadeMenuView ?: 1.0f;
        //        self.contentViewContainer.alpha = self.contentViewFadeOutAlpha;
        self.menuViewContainer.transform = CGAffineTransformIdentity;
        if (self.scaleBackgroundImageView)
        {
            self.backgroundImageView.transform = CGAffineTransformIdentity;
        }
    }completion:^(BOOL finished) {
         [self.leftMenuViewController endAppearanceTransition];
         
         if (!self.visible && [self.delegate conformsToProtocol:@protocol(SliderMenuDelegate)] && [self.delegate respondsToSelector:@selector(sideMenu:didShowMenuViewController:)]) {
             [self.delegate sideMenu:self didShowMenuViewController:self.leftMenuViewController];
         }
         
         self.visible = YES;
         self.leftMenuVisible = YES;
        _leftMenuIsShow = YES;
     }];

}

- (void)showRightMenuViewController{
    //
    
    [self presentMenuViewContainerWithMenuViewController:self.rightMenuViewController];
    
    if (!self.rightMenuViewController) {
        return;
    }
    
    if (_rightMenuIsShow) {
        
        
        [self.rightMenuViewController beginAppearanceTransition:YES animated:YES];
        
        [UIView animateWithDuration:self.animationDuration animations:^{
            
            self.menuViewContainer.alpha = 0;
            self.contentViewController.view.alpha = 1;
            
            self.contentViewContainer.transform = CGAffineTransformIdentity;
            self.contentViewContainer.frame = self.view.bounds;
            
            self.backgroundImageView.transform = CGAffineTransformMakeScale(1.7f, 1.7f);
            
        }completion:^(BOOL finished) {
            [self.rightMenuViewController endAppearanceTransition];
            self.rightMenuViewController.view.hidden = YES;
        }];
        
        [self hideMenuViewController];
        
        return;
    }
    
    [self.rightMenuViewController beginAppearanceTransition:YES animated:YES];
    self.leftMenuViewController.view.hidden = YES;
    self.rightMenuViewController.view.hidden = NO;
    [self.view.window endEditing:YES];
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        if (self.scaleContentView) {
            //设置homeview的缩放倍数
            self.contentViewContainer.transform = CGAffineTransformMakeScale(1, 1);
        } else {
            self.contentViewContainer.transform = CGAffineTransformIdentity;
        }
        
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
            //设置homeview的位置
            self.contentViewContainer.center = CGPointMake(self.view.frame.size.width*1/5, self.view.frame.size.height/2);
            
        } else {
            self.contentViewContainer.center = CGPointMake(self.view.frame.size.width*1/5, self.view.frame.size.height/2);
        }
        
        self.menuViewContainer.alpha = !self.fadeMenuView ?: 1.0f;
        //        self.contentViewContainer.alpha = self.contentViewFadeOutAlpha;
        self.menuViewContainer.transform = CGAffineTransformIdentity;
        if (self.scaleBackgroundImageView)
        {
            self.backgroundImageView.transform = CGAffineTransformIdentity;
        }
        
    }completion:^(BOOL finished) {
        [self.rightMenuViewController endAppearanceTransition];
        
        if (!self.visible && [self.delegate conformsToProtocol:@protocol(SliderMenuDelegate)] && [self.delegate respondsToSelector:@selector(sideMenu:didShowMenuViewController:)]) {
            [self.delegate sideMenu:self didShowMenuViewController:self.rightMenuViewController];
        }
        
        self.visible = YES;
        self.rightMenuVisible = YES;
        _rightMenuIsShow = YES;
    }];

    
}
- (void)hideMenuViewController{
//    self.menuViewContainer.transform = CGAffineTransformIdentity;
    _leftMenuIsShow = NO;
    _rightMenuIsShow = NO;
}

- (void)setContentViewController:(UIViewController *)contentViewController animated:(BOOL)animated{
    if (_contentViewController == contentViewController)
    {
        return;
    }
    
    if (!animated) {
        [self setContentViewController:contentViewController];
    } else {
        [self addChildViewController:contentViewController];
        contentViewController.view.alpha = 0;
        contentViewController.view.frame = self.contentViewContainer.bounds;
        [self.contentViewContainer addSubview:contentViewController.view];
        [UIView animateWithDuration:self.animationDuration animations:^{
            
            contentViewController.view.alpha = 1;
            
            self.contentViewContainer.transform = CGAffineTransformIdentity;
            self.contentViewContainer.frame = self.view.bounds;


        } completion:^(BOOL finished) {
            [self hideViewController:self.contentViewController];
            [contentViewController didMoveToParentViewController:self];
            _contentViewController = contentViewController;
            
            if (self.visible) {
                
            }
        }];
    }
}

#pragma mark Setters

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    if (self.backgroundImageView)
        self.backgroundImageView.image = backgroundImage;
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    if (!_contentViewController) {
        _contentViewController = contentViewController;
        return;
    }
    [self hideViewController:_contentViewController];
    _contentViewController = contentViewController;
    
    [self addChildViewController:self.contentViewController];
    self.contentViewController.view.frame = self.view.bounds;
    [self.contentViewContainer addSubview:self.contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
    
//    [self updateContentViewShadow];
    
    if (self.visible) {
//        [self addContentViewControllerMotionEffects];
    }
}

- (void)setLeftMenuViewController:(UIViewController *)leftMenuViewController
{
    if (!_leftMenuViewController) {
        _leftMenuViewController = leftMenuViewController;
        return;
    }
//    [self hideViewController:_leftMenuViewController];
    _leftMenuViewController = leftMenuViewController;
    
    [self addChildViewController:self.leftMenuViewController];
    self.leftMenuViewController.view.frame = self.view.bounds;
    self.leftMenuViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.menuViewContainer addSubview:self.leftMenuViewController.view];
    [self.leftMenuViewController didMoveToParentViewController:self];
    
//    [self addMenuViewControllerMotionEffects];
    [self.view bringSubviewToFront:self.contentViewContainer];
}

- (void)setRightMenuViewController:(UIViewController *)rightMenuViewController
{
    if (!_rightMenuViewController) {
        _rightMenuViewController = rightMenuViewController;
        return;
    }
    [self hideViewController:_rightMenuViewController];
    _rightMenuViewController = rightMenuViewController;
    
    [self addChildViewController:self.rightMenuViewController];
    self.rightMenuViewController.view.frame = self.view.bounds;
    self.rightMenuViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.menuViewContainer addSubview:self.rightMenuViewController.view];
    [self.rightMenuViewController didMoveToParentViewController:self];
    
//    [self addMenuViewControllerMotionEffects];
    [self.view bringSubviewToFront:self.contentViewContainer];
}

- (void)hideViewController:(UIViewController *)viewController
{
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.image = self.backgroundImage;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView;
    });
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.menuViewContainer];
    [self.view addSubview:self.contentViewContainer];
    
    self.menuViewContainer.frame = self.view.bounds;
    self.menuViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (self.leftMenuViewController) {
        [self addChildViewController:self.leftMenuViewController];
        self.leftMenuViewController.view.frame = self.view.bounds;
        self.leftMenuViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.menuViewContainer addSubview:self.leftMenuViewController.view];
        [self.leftMenuViewController didMoveToParentViewController:self];
    }
    
    if (self.rightMenuViewController) {
        [self addChildViewController:self.rightMenuViewController];
        self.rightMenuViewController.view.frame = self.view.bounds;
        self.rightMenuViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.menuViewContainer addSubview:self.rightMenuViewController.view];
        [self.rightMenuViewController didMoveToParentViewController:self];
    }
    
    self.contentViewContainer.frame = self.view.bounds;
    self.contentViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addChildViewController:self.contentViewController];
    self.contentViewController.view.frame = self.view.bounds;
    [self.contentViewContainer addSubview:self.contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
    
    self.menuViewContainer.alpha = !self.fadeMenuView ?: 0;
    if (self.scaleBackgroundImageView)
        self.backgroundImageView.transform = CGAffineTransformMakeScale(1.7f, 1.7f);

    
    if (self.enableGesture) {
        self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        
        self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        
        [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
        [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    }
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    
    if ([self.delegate conformsToProtocol:@protocol(SliderMenuDelegate)] && [self.delegate respondsToSelector:@selector(sideMenu:didRecognizePanGesture:)])

    
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (_leftMenuIsShow) {
            return;
        }
        [self showLeftMenuViewController];
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (_rightMenuIsShow) {
            return;
        }
        [self showLeftMenuViewController];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (_leftMenuIsShow) {
        [self showLeftMenuViewController];
    }
    
    if (_rightMenuIsShow) {
        [self showRightMenuViewController];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
