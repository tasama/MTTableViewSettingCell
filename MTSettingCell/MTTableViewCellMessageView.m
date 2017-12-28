//
//  MTTableViewCellMessageView.m
//  MTTableViewCell
//
//  Created by tasama on 17/12/21.
//  Copyright © 2017年 MoemoeTechnology. All rights reserved.
//

#import "MTTableViewCellMessageView.h"

@interface MTTableViewCellMessageView () {
    
    CGFloat _labelWidth;
    CGFloat _labelHeight;
}

@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation MTTableViewCellMessageView

- (instancetype)init {
    
    if (self =[super init]) {
        
        _font = [UIFont systemFontOfSize:8.0f];
        
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI {
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.messageLabel];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.messageLabel.frame = CGRectMake((self.bounds.size.width - _labelWidth) / 2.0f, (self.bounds.size.height - _labelHeight) / 2.0f, _labelWidth, _labelHeight);
    self.messageLabel.bounds = CGRectMake(0, 0, _labelWidth, _labelHeight);
    self.messageLabel.layer.cornerRadius = _labelHeight / 2.0f;
    self.messageLabel.layer.masksToBounds = YES;
}

#pragma mark - Getter & Setter

- (UILabel *)messageLabel {
    
    if (!_messageLabel) {
        
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:8.0f];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.backgroundColor = [UIColor redColor];
    }
    return _messageLabel;
}

- (void)setMessageNum:(NSInteger)messageNum {
    
    _messageNum = messageNum;
    
    if (messageNum > 0) {

        NSString *message = [NSString stringWithFormat:@"%zd", messageNum];
        
        CGRect rect = [message boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _font} context:nil];
        
        _labelHeight = rect.size.height + 6;
        _labelWidth = rect.size.width + 6 < _labelHeight ? _labelHeight : rect.size.width + 6;
        
        self.messageLabel.text = [NSString stringWithFormat:@"%zd", messageNum];
    } else {
        
        self.messageLabel.text = @"";
        _labelHeight = 0;
        _labelWidth = 0;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setFont:(UIFont *)font {
    
    _font = font;
    
    NSString *message = self.messageLabel.text;
    CGRect rect = [message boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _font} context:nil];
    
    _labelHeight = rect.size.height + 6;
    _labelWidth = rect.size.width + 6 < _labelHeight ? _labelHeight : rect.size.width + 6;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setMTintColor:(UIColor *)mTintColor {
    
    _mTintColor = mTintColor;
    self.messageLabel.backgroundColor = mTintColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    
    _titleColor = titleColor;
    self.messageLabel.textColor = titleColor;
}

@end
