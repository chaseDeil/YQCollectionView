//
//  YQMoveCollectionViewCell.m
//  YQCollectionView
//
//  Created by chase on 16/2/18.
//  Copyright © 2016年 chase_liu. All rights reserved.
//

#import "YQMoveCollectionViewCell.h"

@implementation YQMoveCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width / 2 - 20, 10, 40, 40)];
        _logoImg.backgroundColor = [UIColor blackColor];
        [self addSubview:_logoImg];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_logoImg.frame.origin.x, _logoImg.frame.origin.y + _logoImg.frame.size.height + 8, 40, 20)];
        _titleLabel.backgroundColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

@end
