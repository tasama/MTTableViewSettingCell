//
//  MTTableViewCell.h
//  MTTableViewCell
//
//  Created by tasama on 17/12/21.
//  Copyright © 2017年 MoemoeTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTTableViewCellMessageView.h"

typedef NS_OPTIONS(NSUInteger, MTTableViewCellStyle) {
    MTTableViewCellStyleDefault         = 0, //默认样式：只包含mTitleLabel居左
    MTTableViewCellStyleMessage       = 1 << 0, //包含mTitleLabel， messageView
    MTTableViewCellStyleSwitch          = 1 << 1,//包含mTitleLabel， mSwitch
    MTTableViewCellStyleSubtitle         = 1 << 2 //包含mTitleLabel，mSubtitleLabel
};

@class MTTableViewCell;
@protocol MTTableViewCellDelegate <NSObject>

- (void)tableViewCell:(MTTableViewCell *)cell switchBtnDidChangeValue:(UISwitch *)switchBtn;

@end

@interface MTTableViewCell : UITableViewCell

///坐标的icon
@property (nonatomic, strong, readonly) UIImageView *mLeftIcon;

///主标题
@property (nonatomic, strong, readonly) UILabel *mTitleLabel;

///副标题
@property (nonatomic, strong, readonly) UILabel *mSubTitleLabel;

///switch开关
@property (nonatomic, strong, readonly) UISwitch *mSwitchBtn;

///消息数量View
@property (nonatomic, strong, readonly) MTTableViewCellMessageView *messageView;

///左边图标
@property (nonatomic, strong) UIImage *iconImage;

///是否有右边箭头
@property (nonatomic, assign) BOOL showRightArrow;

@property (nonatomic, weak) id <MTTableViewCellDelegate> delegate;


/**
 cell便利初始化方法

 @param tableView       tableView
 @param style           cell类型
 @param reuseIdentifier 重用ID

 @return MTTableViewCell
 */
+ (instancetype)MT_initByTableView:(UITableView *)tableView
                                    WithStyle:(MTTableViewCellStyle)style
                             reuseIdentifier:(NSString *)reuseIdentifier;


@end
