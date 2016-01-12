//
//  ZSRMessageModel.h
//  QChatUI
//
//  Created by hp on 16/1/11.
//  Copyright © 2016年 hp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ZSRMessageModelGatsby = 0,//Gatsby
    ZSRMessageModelJobs//Jobs
}ZSRMessageModelType;
@interface ZSRMessageModel : NSObject

//正文
@property (nonatomic, copy)NSString *text;

//时间
@property (nonatomic, copy)NSString *time;

//发送类型
@property (nonatomic, assign)ZSRMessageModelType type;

//是否隐藏时间
@property (nonatomic,assign)BOOL hideTime;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
@end
