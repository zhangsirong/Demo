//
//  ZSRWeiboCell.m
//  myweibo
//
//  Created by hp on 16/1/10.
//  Copyright © 2016年 hp. All rights reserved.
//

#import "ZSRWeiboCell.h"
#import "ZSRWeiboFrame.h"
#import "ZSRWeibo.h"
@interface ZSRWeiboCell()
// 1.头像
@property (nonatomic, weak) UIImageView *iconView;
// 2.昵称
@property (nonatomic, weak) UILabel *nameLabel;
// 3.会员图标
@property (nonatomic, weak) UIImageView *vipView;
// 4.正文
@property (nonatomic, weak) UILabel *textView;
// 5.配图
@property (nonatomic, weak) UIImageView *pictureView;

@end
@implementation ZSRWeiboCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 添加内部的子控件
        
        // 1.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        // 2.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = kNameFont;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 3.会员图标
        UIImageView *vipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vip.png"]];
        [self.contentView addSubview:vipView];
        self.vipView = vipView;
        
        // 4.微博正文
        UILabel *textView = [[UILabel alloc] init];
        textView.font = kTextFont;
        textView.numberOfLines = 0; // 自动换行
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        // 5.配图
        UIImageView *pictureView = [[UIImageView alloc] init];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
        
    }
    return self;
}

- (void)setWeiboFrame:(ZSRWeiboFrame *)weiboFrame
{
    _weiboFrame = weiboFrame;
    
    // 1.设置微博数据
    [self settingData];
    
    // 2.设置子控件的frame（x、y、width、height）
    [self settingSubviewFrame];
}
#pragma mark 设置子控件的frame
- (void)settingSubviewFrame
{
    // 1.头像
    self.iconView.frame = self.weiboFrame.iconF;
    
    // 2.昵称
    self.nameLabel.frame = self.weiboFrame.nameF;
    
    // 3.vip
    self.vipView.frame = self.weiboFrame.vipF;
    
    // 4.正文
    self.textView.frame = self.weiboFrame.textF;
    
    // 5.配图
    if (self.weiboFrame.weibo.picture) { // 有配图
        self.pictureView.frame = self.weiboFrame.pictureF;
    }
}

#pragma mark 设置微博数据
- (void)settingData
{
    ZSRWeibo *weibo = self.weiboFrame.weibo;
    
    // 1.头像
    self.iconView.image = [UIImage imageNamed:weibo.icon];

    // 2.昵称
    self.nameLabel.text = weibo.name;
    if (weibo.vip) {
        self.nameLabel.textColor = [UIColor redColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 3.会员图标
    self.vipView.hidden = !weibo.vip;
    
    // 4.正文
    self.textView.text = weibo.text;
    
    // 5.配图
    if (weibo.picture) { // 有配图
        self.pictureView.hidden = NO;
        
        self.pictureView.image = [UIImage imageNamed:weibo.picture];
    } else { // 没有配图
        self.pictureView.hidden = YES;
    }
  
}

@end
