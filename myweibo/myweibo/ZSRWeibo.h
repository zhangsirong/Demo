//
//  ZSRWeibo.h
//  myweibo
//
//  Created by hp on 16/1/10.
//  Copyright © 2016年 hp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSRWeibo : NSObject
@property (nonatomic, copy) NSString *text; // 内容
@property (nonatomic, copy) NSString *icon; // 头像
@property (nonatomic, copy) NSString *name; // 昵称
@property (nonatomic, copy) NSString *picture; // 配图

@property (nonatomic, assign) BOOL vip;
- (id)initWithDict:(NSDictionary *)dict;
+ (id)weiboWithDict:(NSDictionary *)dict;
@end
