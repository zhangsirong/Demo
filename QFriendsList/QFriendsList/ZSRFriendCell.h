//
//  ZSRFriendCell.h
//  QFriendsList
//
//  Created by hp on 16/1/10.
//  Copyright © 2016年 hp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZSRFriend;
@interface ZSRFriendCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) ZSRFriend *friendData;

@end
