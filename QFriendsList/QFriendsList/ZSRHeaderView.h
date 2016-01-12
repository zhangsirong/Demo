//
//  ZSRHeaderView.h
//  QFriendsList
//
//  Created by hp on 16/1/10.
//  Copyright © 2016年 hp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZSRFriendGroup, ZSRHeaderView;

typedef void(^ZSRHeaderViewBlock)(id);

@protocol ZSRHeaderViewDelegate <NSObject>
@optional
- (void)headerViewDidClickedNameView:(ZSRHeaderView *)headerView;
@end

@interface ZSRHeaderView : UITableViewHeaderFooterView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) ZSRFriendGroup *group;

@property (nonatomic, weak) id<ZSRHeaderViewDelegate> delegate;

@property (nonatomic, copy)ZSRHeaderViewBlock block;

@end
