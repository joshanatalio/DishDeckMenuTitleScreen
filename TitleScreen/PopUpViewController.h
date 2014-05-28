//
//  PopUpViewController.h
//  TitleScreen
//
//  Created by Josh Anatalio on 5/19/14.
//  Copyright (c) 2014 JoshAnatalio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopUpViewController : UIViewController
@property (nonatomic, assign) BOOL showStatusBar;
@property (nonatomic, strong) UIImageView *itemPictureView;
@property (strong, nonatomic) IBOutlet UIImageView *itemPictureImageView;
@property (strong, nonatomic) UIImage *foodPic;
@property (weak, nonatomic) IBOutlet UILabel *foodDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodTitleLabel;
@end
