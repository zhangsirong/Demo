//
//  ZSRMessageCell.m
//  QChatUI
//
//  Created by hp on 16/1/11.
//  Copyright © 2016年 hp. All rights reserved.
//

#import "ZSRMessageCell.h"
#import "ZSRMessageFrameModel.h"
#import "ZSRMessageModel.h"
#import "Constant.h"
#import "UIImage+ResizImage.h"
@interface ZSRMessageCell()
//时间
@property (nonatomic, weak)UILabel *time;
//正文
@property (nonatomic, weak)UIButton *textView;
//用户头像
@property (nonatomic, weak)UIImageView *icon;

@end
@implementation ZSRMessageCell

+ (instancetype)messageCellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"cell";
    ZSRMessageCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return  cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1 时间
        UILabel *time = [[UILabel alloc] init];
        time.textAlignment = NSTextAlignmentCenter;
        time.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:time];
        self.time = time;
        
        //2.正文
        UIButton *textView = [[UIButton alloc]init];
        textView.titleLabel.font = bBtnFont;
        textView.titleLabel.numberOfLines = 0;//自动换行
        textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        //3.头像
        UIImageView *icon = [[UIImageView alloc]init];
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}
-(void)setFrameMessage:(ZSRMessageFrameModel *)frameMessage
{
    _frameMessage = frameMessage;
    
    ZSRMessageModel *model = frameMessage.message;
    //1.时间
    self.time.frame = frameMessage.timeF;
    self.time.text = model.time;
    
    //2.头像
    self.icon.frame = frameMessage.iconF;
    if (model.type == ZSRMessageModelGatsby) {
        self.icon.image = [UIImage imageNamed:@"Gatsby"];
    }else{
        self.icon.image = [UIImage imageNamed:@"Jobs"];
    }
    
    //3.正文
    self.textView.frame = frameMessage.textViewF;
    [self.textView setTitle:model.text forState:UIControlStateNormal];
    
    if (model.type == ZSRMessageModelGatsby) {
//                [self.textView setBackgroundImage:[self resizeWithImageName:@"chat_send_nor"] forState:UIControlStateNormal];
        
        [self.textView setBackgroundImage:[UIImage resizeWithImageName:@"chat_send_nor"] forState:UIControlStateNormal];//chat_send_nor
    }else{
        [self.textView setBackgroundImage:[UIImage resizeWithImageName:@"chat_recive_nor"] forState:UIControlStateNormal];
    }
    
}

@end
