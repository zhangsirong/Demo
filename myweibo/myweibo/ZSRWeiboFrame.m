//
//  ZSRWeiboFrame.m
//  myweibo
//
//  Created by hp on 16/1/10.
//  Copyright © 2016年 hp. All rights reserved.
//

// cell的边框宽度
#define kCellBorder 10
// 头像的宽高
#define kIconWH 30
// vip的宽高
#define kVipWH 14
// 图片尺寸
#define kImageWH 70

#import "ZSRWeiboFrame.h"
#import "ZSRWeibo.h"
@implementation ZSRWeiboFrame
- (void)setWeibo:(ZSRWeibo *)weibo
{
    _weibo = weibo;
    // 1.头像
    CGFloat iconX = kCellBorder;
    CGFloat iconY = kCellBorder;
    _iconF = CGRectMake(iconX, iconY, kIconWH, kIconWH);
    
    // 2.昵称
    // 计算用户名称的尺寸
    CGSize nameSize = [_weibo.name sizeWithFont:kNameFont];
    CGFloat nameX = CGRectGetMaxX(_iconF) + kCellBorder;
    CGFloat nameY = iconY + (kIconWH - nameSize.height) * 0.5;
    _nameF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    // 3.vip
    CGFloat vipX = CGRectGetMaxX(_nameF) + kCellBorder;
    CGFloat vipY = nameY;
    _vipF = CGRectMake(vipX, vipY, kVipWH, kVipWH);

    
    // 4.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_iconF) + kCellBorder;
    CGFloat textW = 320 - 2 * kCellBorder;
    // 计算文字尺寸（显示文字的宽度）
    CGSize textSize = [_weibo.text sizeWithFont:kTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    
    _textF = CGRectMake(textX, textY, textW, textSize.height);
    
    // 5.配图\计算cell的高度
    if (_weibo.picture) { // 有配图
        CGFloat pictureX = textX;
        CGFloat pictureY = CGRectGetMaxY(_textF) + kCellBorder;
        _pictureF = CGRectMake(pictureX, pictureY, kImageWH, kImageWH);
        
        _cellHeight = CGRectGetMaxY(_pictureF) + kCellBorder;
    } else { // 没有配图
        _cellHeight = CGRectGetMaxY(_textF) + kCellBorder;
    }
}
@end
