//
//  ZSRTableViewController.m
//  QFriendsList
//
//  Created by hp on 16/1/10.
//  Copyright © 2016年 hp. All rights reserved.
//

#import "ZSRTableViewController.h"
#import "ZSRFriend.h"
#import "ZSRFriendGroup.h"
#import "ZSRHeaderView.h"
#import "ZSRFriendCell.h"
@interface ZSRTableViewController ()//<ZSRHeaderViewDelegate>
@property (nonatomic, strong) NSArray *groups;
@end

@implementation ZSRTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60;
    self.tableView.sectionHeaderHeight = 60;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiClcik) name:@"friend" object:nil];
}

- (void)notiClcik
{
    [self.tableView reloadData];
}

- (NSArray *)groups
{
    if (_groups == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil]];
        
        NSMutableArray *groupArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            ZSRFriendGroup *group = [ZSRFriendGroup groupWithDict:dict];
            [groupArray addObject:group];
        }
        
        _groups = groupArray;
    }
    return _groups;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

     return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    ZSRFriendGroup *group = self.groups[section];
    return group.isOpened ? group.friends.count : 0 ;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZSRFriendCell *cell = [ZSRFriendCell cellWithTableView:tableView];
    
    ZSRFriendGroup *group = self.groups[indexPath.section];
    cell.friendData = group.friends[indexPath.row];
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZSRHeaderView *header = [ZSRHeaderView headerViewWithTableView:tableView];
//    header.delegate = self;
    
    header.group = self.groups[section];
    
    return header;
}
#pragma mark - headerView的代理方法

//- (void)headerViewDidClickedNameView:(ZSRHeaderView *)headerView
//{
//    [self.tableView reloadData];
//}

@end
