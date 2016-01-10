//
//  ZSRWeiboFrame.h
//  myweibo
//
//  Created by hp on 16/1/10.
//  Copyright © 2016年 hp. All rights reserved.
//
#define kNameFont [UIFont systemFontOfSize:15]
#define kTextFont [UIFont systemFontOfSize:15]
#import <Foundation/Foundation.h>

@class ZSRWeibo;
@interface ZSRWeiboFrame : NSObject

@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect nameF;
@property (nonatomic, assign, readonly) CGRect vipF;
@property (nonatomic, assign, readonly) CGRect textF;
@property (nonatomic, assign, readonly) CGRect pictureF;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, strong) ZSRWeibo *weibo;
@end
