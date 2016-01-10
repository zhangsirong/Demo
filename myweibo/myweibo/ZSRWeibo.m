//
//  ZSRWeibo.m
//  myweibo
//
//  Created by hp on 16/1/10.
//  Copyright © 2016年 hp. All rights reserved.
//

#import "ZSRWeibo.h"

@implementation ZSRWeibo
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = ([super init])) {
        self.name = dict[@"name"];
        self.vip = [dict[@"vip"] boolValue];
        self.picture = dict[@"picture"];
        self.text = dict[@"text"];
        self.icon = dict[@"icon"];
    }
    return self;
}

+ (id)weiboWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
