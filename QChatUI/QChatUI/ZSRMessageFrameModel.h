//
//  ZSRMessageFrameModel.h
//  QChatUI
//
//  Created by hp on 16/1/11.
//  Copyright © 2016年 hp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZSRMessageModel;

@interface ZSRMessageFrameModel : NSObject
//时间的frame
@property (nonatomic, assign,readonly)CGRect timeF;

//正文的frame
@property (nonatomic, assign,readonly)CGRect textViewF;

//图片
@property (nonatomic, assign,readonly)CGRect iconF;

//cell
@property (nonatomic, assign,readonly)CGFloat cellH;

//数据模型
@property (nonatomic, strong)ZSRMessageModel *message;
@end
