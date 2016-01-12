//
//  ZSRMessageCell.h
//  QChatUI
//
//  Created by hp on 16/1/11.
//  Copyright © 2016年 hp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZSRMessageFrameModel;
@interface ZSRMessageCell : UITableViewCell

+ (instancetype)messageCellWithTableView:(UITableView *)tableview;

//frame 的模型
@property (nonatomic, strong)ZSRMessageFrameModel *frameMessage;

@end
