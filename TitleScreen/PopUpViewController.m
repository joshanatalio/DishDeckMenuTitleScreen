//
//  PopUpViewController.m
//  TitleScreen
//
//  Created by Josh Anatalio on 5/19/14.
//  Copyright (c) 2014 JoshAnatalio. All rights reserved.
//

#import "PopUpViewController.h"
#import "MZFormSheetController.h"

@interface PopUpViewController ()

@end

@implementation PopUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(!self.foodPic)
    {
        NSLog(@"Food pic is null");
    }
    self.foodTitleLabel.text  = @"test";
    self.itemPictureImageView.image = self.foodPic;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Access to form sheet controller
    MZFormSheetController *controller = self.navigationController.formSheetController;
    controller.shouldDismissOnBackgroundViewTap = YES;
    
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.showStatusBar = NO;
    [UIView animateWithDuration:0.3 animations:^{
        [self.navigationController.formSheetController setNeedsStatusBarAppearanceUpdate];
    }];
    
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent; // your own style
}

- (BOOL)prefersStatusBarHidden {
    return self.showStatusBar; // your own visibility code
}

@end
