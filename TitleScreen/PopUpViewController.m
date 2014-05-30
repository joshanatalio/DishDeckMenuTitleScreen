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
     self.itemPictureImageView.image = self.foodPic;
    self.foodNameLabel.text = self.foodNameString;
    self.foodDescriptionLabel.text = self.foodDescriptionString;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Access to form sheet controller
    MZFormSheetController *controller = self.navigationController.formSheetController;
    controller.shouldDismissOnBackgroundViewTap = YES;
    
}

-(UILabel *)foodNameLabel{
    if(!_foodNameLabel)
    {
        
        _foodNameLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
        [_foodNameLabel setFont:[UIFont fontWithName:@"Euphemia UCAS" size:12]];
        _foodNameLabel.text = @"Cheeseburger"; // just for testing purposes
        
        _foodNameLabel.textColor = [UIColor blackColor];
    }
    
    return _foodNameLabel;
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
