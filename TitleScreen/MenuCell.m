//
//  MenuCell.m
//  TitleScreen
//
//  Created by Josh Anatalio on 5/4/14.
//  Copyright (c) 2014 JoshAnatalio. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (UIImageView *)backgroundImage{
    
    if(!_backgroundImage)
    {
        _backgroundImage = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        
        
    }
    return _backgroundImage;
}
-(UILabel *)displayLabel{
    if(!_displayLabel)
    {
        _displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height-20, self.contentView.frame.size.width, 20)];
        _displayLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
        [_displayLabel setFont:[UIFont fontWithName:@"Euphemia UCAS" size:12]];
        _displayLabel.text = @" $11.99"; // just for testing purposes
        
        _displayLabel.textColor = [UIColor whiteColor];
        
    }
    
    return _displayLabel;
}




- (id)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.backgroundImage];
        [self.contentView addSubview:self.displayLabel];
        
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
