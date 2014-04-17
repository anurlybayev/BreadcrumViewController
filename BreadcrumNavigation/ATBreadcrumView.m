//
//  ATBreadcrumView.m
//  BreadcrumNavigation
//
//  Created by Akbar Nurlybayev on 2014-04-16.
//  Copyright (c) 2014 Akbar Nurlybayev. All rights reserved.
//

#import "ATBreadcrumView.h"

CGFloat const kNavigationIconOffset = 24.0f;
CGFloat const kTitleLabelHeight = 21.0f;
CGFloat const kSubtitleLabelHeight = 17.0f;

@implementation ATBreadcrumView

@synthesize titleLabel = _titleLabel;
@synthesize subtitleLabel = _subtitleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGRect frame = CGRectZero;
        CGFloat width = CGRectGetMaxX(self.bounds) - kNavigationIconOffset;
        if (!_subtitleLabel) {
            frame = CGRectMake(0.0f, CGRectGetMidY(self.bounds) - kTitleLabelHeight/2, width, kTitleLabelHeight);
        } else {
            CGFloat yOffset = CGRectGetMidY(self.bounds) - (kTitleLabelHeight + kSubtitleLabelHeight + 4.0f)/2;
            frame = CGRectMake(0.0f, yOffset, width, kTitleLabelHeight);
            
            yOffset += kTitleLabelHeight + 4.0f;
            CGRect subtitleFrame = _subtitleLabel.frame;
            subtitleFrame.origin.y = yOffset;
            _subtitleLabel.frame = subtitleFrame;
        }
        _titleLabel = [[UILabel alloc] initWithFrame:frame];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        CGRect frame = CGRectZero;
        CGFloat width = CGRectGetMaxX(self.bounds) - kNavigationIconOffset;
        if (!_titleLabel) {
            frame = CGRectMake(0.0f, CGRectGetMidY(self.bounds) - kSubtitleLabelHeight/2, width, kSubtitleLabelHeight);
        } else {
            CGFloat yOffset = CGRectGetMidY(self.bounds) - (kTitleLabelHeight + kSubtitleLabelHeight + 4.0f)/2;
            CGRect titleFrame = _titleLabel.frame;
            titleFrame.origin.y = yOffset;
            _titleLabel.frame = titleFrame;
            
            yOffset += kTitleLabelHeight + 4.0f;
            frame = CGRectMake(0.0f, yOffset, width, kSubtitleLabelHeight);
        }
        _subtitleLabel = [[UILabel alloc] initWithFrame:frame];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:_subtitleLabel];
    }
    return _subtitleLabel;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMaxX(rect) - kNavigationIconOffset, CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMidY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect) - kNavigationIconOffset, CGRectGetMaxY(rect));
    
    CGContextSetStrokeColorWithColor(ctx, [[UIColor lightGrayColor] CGColor]);
    CGContextStrokePath(ctx);
}


@end
