//
//  MTTableViewCell.m
//  MTTableViewCell
//
//  Created by tasama on 17/12/21.
//  Copyright © 2017年 MoemoeTechnology. All rights reserved.
//

#import "MTTableViewCell.h"

@interface UIView (layout)

@property (nonatomic, assign) CGFloat mWidth;

@property (nonatomic, assign) CGFloat mHeight;

@property (nonatomic, assign) CGFloat mLeft;

@property (nonatomic, assign) CGFloat mRight;

@property (nonatomic, assign) CGFloat mTop;

@property (nonatomic, assign) CGFloat mBottom;

@end

@implementation UIView (layout)

- (void)setMWidth:(CGFloat)mWidth {
    
    CGSize size = self.bounds.size;
    size.width = mWidth;
    self.bounds = CGRectMake(0, 0, size.width, size.height);
}

- (CGFloat)mWidth {
    
    return self.bounds.size.width;
}

- (void)setMHeight:(CGFloat)mHeight {
    
    CGSize size = self.bounds.size;
    size.height = mHeight;
    self.bounds = CGRectMake(0, 0, size.width, size.height);
}

- (CGFloat)mHeight {
    
    return self.bounds.size.height;
}

- (void)setMLeft:(CGFloat)mLeft {
    
    CGPoint origin = self.frame.origin;
    origin.x = mLeft;
    
    self.frame = CGRectOffset(self.bounds, origin.x, origin.y);
}

- (CGFloat)mLeft {
    
    return self.frame.origin.x;
}

- (void)setMRight:(CGFloat)mRight {
    
    CGPoint origin = self.frame.origin;
    origin.x = mRight - self.bounds.size.width;
    
    self.frame = CGRectOffset(self.bounds, origin.x, origin.y);
}

- (CGFloat)mRight {
    
    return self.frame.origin.x + self.bounds.size.width;
}

- (void)setMTop:(CGFloat)mTop {
    
    CGPoint origin = self.frame.origin;
    origin.y = mTop;
    
    self.frame = CGRectOffset(self.bounds, origin.x, origin.y);
}

- (CGFloat)mTop {
    
    return self.frame.origin.y;
}

- (void)setMBottom:(CGFloat)mBottom {
    
    CGPoint origin = self.frame.origin;
    origin.y = mBottom - self.bounds.size.height;
    
    self.frame = CGRectOffset(self.bounds, origin.x, origin.y);
}

- (CGFloat)mBottom {
    
    return self.frame.origin.y + self.bounds.size.height;
}

@end

@interface MTTableViewCell () {
    
    CGSize _iconImageSize;
    CGSize _rightArrowSize;
}

@property (nonatomic, strong, readwrite) UILabel *mTitleLabel;

@property (nonatomic, strong, readwrite) UILabel *mSubTitleLabel;

@property (nonatomic, strong, readwrite) UIImageView *mLeftIcon;

@property (nonatomic, strong, readwrite) UISwitch *mSwitchBtn;

@property (nonatomic, strong) UIImageView *rightArrow;

@property (nonatomic, strong, readwrite) MTTableViewCellMessageView *messageView;

@property (nonatomic, assign) MTTableViewCellStyle style;

@end

@implementation MTTableViewCell

#pragma mark - View Init

+ (instancetype)MT_initByTableView:(UITableView *)tableView WithStyle:(MTTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    MTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        
        cell = [[MTTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.style = style;
    
    return cell;
}

CGFloat letfMargin = 15.0f;

#pragma mark - Layout UI
- (void)layoutSubviews {
    
    [super layoutSubviews];

    [self layoutIconView];
    [self layoutMTitleLabelWithStyle:self.style];
    [self layoutMSubTitleLabelWithStyle:self.style];
    [self layoutMSwitchBtnWithStyle:self.style];
    [self layoutMessageViewWithStyle:self.style];
    [self layoutRightArrow];
}

- (void)layoutIconView {
    
    if (!CGSizeEqualToSize(_iconImageSize, CGSizeZero)) {
        
        if (_iconImageSize.height > self.contentView.mHeight) {
            
            CGFloat rate = _iconImageSize.width / _iconImageSize.height;
            
            _iconImageSize.width = self.contentView.mHeight * rate;
            _iconImageSize.height = self.contentView.mHeight;
        }
        _mLeftIcon.frame = CGRectMake(letfMargin, (self.contentView.mHeight - _iconImageSize.height) / 2.0f, _iconImageSize.width, _iconImageSize.height);
    } else {
        
        _mLeftIcon.frame = CGRectZero;
    }
}

- (void)layoutMTitleLabelWithStyle:(MTTableViewCellStyle)style {
    
    _mTitleLabel.frame = CGRectMake(_mLeftIcon.mRight + letfMargin, 0, self.contentView.mWidth - letfMargin * 2 - _rightArrowSize.width - self.contentView.mHeight, self.contentView.mHeight);
}

- (void)layoutMSubTitleLabelWithStyle:(MTTableViewCellStyle)style {
    
    switch (style) {
        case MTTableViewCellStyleSubtitle: {
            
            CGFloat width = _rightArrowSize.width > 0 ? _rightArrowSize.width + 10 : 0;
            
            _mSubTitleLabel.frame = CGRectMake(self.contentView.mWidth - width - self.contentView.mHeight - letfMargin, 0, self.contentView.mHeight, self.contentView.mHeight);
            _mSubTitleLabel.textAlignment = NSTextAlignmentRight;
        }
            break;
        
        case (MTTableViewCellStyleSubtitle | MTTableViewCellStyleMessage):
        case (MTTableViewCellStyleSubtitle | MTTableViewCellStyleSwitch): {
            
            _mTitleLabel.frame = CGRectMake(_mLeftIcon.mRight + letfMargin, 0, self.contentView.mWidth - letfMargin * 2 - _rightArrowSize.width - self.contentView.mHeight, self.contentView.mHeight / 2.0f);
            _mSubTitleLabel.frame = CGRectMake(_mTitleLabel.mLeft, _mTitleLabel.mBottom, _mTitleLabel.mWidth, self.contentView.mHeight / 2.0f);
            _mSubTitleLabel.textAlignment = NSTextAlignmentLeft;
        }
            break;
            
        default: {
            
            _mSubTitleLabel.frame = CGRectZero;
        }
            break;
    }
}

- (void)layoutMSwitchBtnWithStyle:(MTTableViewCellStyle)style {
    
    switch (style) {
        case MTTableViewCellStyleSwitch:
        case (MTTableViewCellStyleSubtitle | MTTableViewCellStyleSwitch): {
            
            CGFloat width = _rightArrowSize.width > 0 ? _rightArrowSize.width + 10 : 0;
            _mSwitchBtn.frame = CGRectMake(self.contentView.mWidth - width - self.contentView.mHeight - letfMargin, (self.contentView.mHeight - self.mSwitchBtn.mHeight) / 2.0f, self.contentView.mHeight, self.mSwitchBtn.mHeight);
        }
            break;
            
        default:
            _mSwitchBtn.frame = CGRectZero;
            break;
    }
}

- (void)layoutMessageViewWithStyle:(MTTableViewCellStyle)style {
    
    switch (style) {
        case MTTableViewCellStyleMessage:
        case (MTTableViewCellStyleMessage | MTTableViewCellStyleSubtitle): {
            
            _messageView.frame = CGRectMake(self.contentView.mWidth - _rightArrowSize.width - self.contentView.mHeight - letfMargin, 0, self.contentView.mHeight, self.contentView.mHeight);
        }
            break;
            
        default:
            _messageView.frame = CGRectZero;
            break;
    }
}

- (void)layoutRightArrow {
    
    _rightArrow.frame = CGRectMake(self.contentView.mWidth - _rightArrowSize.width - letfMargin, (self.contentView.mHeight - _rightArrowSize.height) / 2.0f, _rightArrowSize.width, _rightArrowSize.height);
}

#pragma mark - Private Method

- (void)switchBtnDidChangeValue:(UISwitch *)switchBtn {
    
    if ([self.delegate respondsToSelector:@selector(tableViewCell:switchBtnDidChangeValue:)]) {
        
        [self.delegate tableViewCell:self switchBtnDidChangeValue:switchBtn];
    }
}

#pragma mark - Getter & Setter

- (void)setStyle:(MTTableViewCellStyle)style {
    
    _style = style;
    [self.contentView addSubview:self.mTitleLabel];

    switch (style) {
            
        case MTTableViewCellStyleDefault: {}
            break;
            
        case MTTableViewCellStyleSwitch: {
            
            [self.contentView addSubview:self.mSwitchBtn];
        }
            break;
            
        case MTTableViewCellStyleMessage: {
            
            [self.contentView addSubview:self.messageView];
        }
            break;
            
        case MTTableViewCellStyleSubtitle: {
            
            [self.contentView addSubview:self.mSubTitleLabel];
        }
            break;
            
        case MTTableViewCellStyleSubtitle | MTTableViewCellStyleMessage: {
            
            [self.contentView addSubview:self.mSubTitleLabel];
            [self.contentView addSubview:self.messageView];
        }
            break;
            
        case MTTableViewCellStyleSubtitle | MTTableViewCellStyleSwitch: {
            
            [self.contentView addSubview:self.mSubTitleLabel];
            [self.contentView addSubview:self.mSwitchBtn];
        }
            break;

        default:
            break;
    }
}

- (void)setIconImage:(UIImage *)iconImage {
    
    _iconImage = iconImage;
    
    if (iconImage) {
        
        _iconImageSize = iconImage.size;
        self.mLeftIcon.image = iconImage;
        [self.contentView addSubview:self.mLeftIcon];
    } else {
        
        _iconImageSize = CGSizeZero;
        [self.mLeftIcon removeFromSuperview];
        self.mLeftIcon = nil;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setShowRightArrow:(BOOL)showRightArrow {
    
    _showRightArrow = showRightArrow;
    if (showRightArrow) {
        
        _rightArrowSize = CGSizeMake(12, 12);
        [self.contentView addSubview:self.rightArrow];
    } else {
        
        _rightArrowSize = CGSizeZero;
        [self.rightArrow removeFromSuperview];
        self.rightArrow = nil;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (UIImageView *)mLeftIcon {
    
    if (!_mLeftIcon) {
        
        _mLeftIcon = [[UIImageView alloc] init];
    }
    return _mLeftIcon;
}

- (UILabel *)mTitleLabel {
    
    if (!_mTitleLabel) {
        
        _mTitleLabel = [[UILabel alloc] init];
        _mTitleLabel.font = [UIFont systemFontOfSize:15.0f];
        _mTitleLabel.textColor = [UIColor darkGrayColor];
    }
    return _mTitleLabel;
}

- (UILabel *)mSubTitleLabel {
    
    if (!_mSubTitleLabel) {
        
        _mSubTitleLabel = [[UILabel alloc] init];
        _mSubTitleLabel.font = [UIFont systemFontOfSize:13.0f];
        _mSubTitleLabel.textColor = [UIColor lightGrayColor];
        _mSubTitleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _mSubTitleLabel;
}

- (UISwitch *)mSwitchBtn {
    
    if (!_mSwitchBtn) {
        
        _mSwitchBtn = [[UISwitch alloc] init];
        [_mSwitchBtn addTarget:self action:@selector(switchBtnDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _mSwitchBtn;
}

- (MTTableViewCellMessageView *)messageView {
    
    if (!_messageView) {
        
        _messageView = [[MTTableViewCellMessageView alloc] init];
        _messageView.messageNum = 0;
    }
    return _messageView;
}

- (UIImageView *)rightArrow {
    
    if (!_rightArrow) {
        
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    }
    return _rightArrow;
}

@end
