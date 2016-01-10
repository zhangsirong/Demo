//
//  ZSRTableViewController.m
//  myweibo
//
//  Created by hp on 16/1/10.
//  Copyright © 2016年 hp. All rights reserved.
//

#import "ZSRTableViewController.h"
#import "ZSRWeiboCell.h"
#import "ZSRWeibo.h"
#import "ZSRWeiboFrame.h"
@interface ZSRTableViewController ()
@property (nonatomic, strong) NSMutableArray *weiboFrames;
@end

@implementation ZSRTableViewController

- (NSMutableArray *)weiboFrames
{
    if (_weiboFrames == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"weibo" ofType:@"plist" ]];
        _weiboFrames = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            ZSRWeiboFrame *weiboF = [[ZSRWeiboFrame alloc] init];
            weiboF.weibo = [ZSRWeibo weiboWithDict:dict];
            [_weiboFrames addObject:weiboF];
        }
    }
    return  _weiboFrames;
}

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weiboFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *ID =@"cell";
    
    ZSRWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZSRWeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.weiboFrame = self.weiboFrames[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.weiboFrames[indexPath.row] cellHeight];
}

@end
