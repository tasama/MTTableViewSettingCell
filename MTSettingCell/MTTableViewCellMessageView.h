//
//  MTTableViewCellMessageView.h
//  MTTableViewCell
//
//  Created by tasama on 17/12/21.
//  Copyright © 2017年 MoemoeTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTTableViewCellMessageView : UIView

///消息数
@property (nonatomic, assign) NSInteger messageNum;

///标题颜色
@property (nonatomic, strong) UIColor *titleColor;

///背景颜色
@property (nonatomic, strong) UIColor *mTintColor;

///文字字体
@property (nonatomic, strong) UIFont *font;

@end
