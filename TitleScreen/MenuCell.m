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
