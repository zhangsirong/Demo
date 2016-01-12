//
//  ViewController.m
//  QChatUI
//
//  Created by hp on 16/1/11.
//  Copyright © 2016年 hp. All rights reserved.
//

#import "ViewController.h"
#import "ZSRMessageCell.h"
#import "ZSRMessageFrameModel.h"
#import "ZSRMessageModel.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputView;

@property (nonatomic, strong)NSMutableArray *messages;

//自动回复数组
@property (nonatomic, strong)NSDictionary *autoReplay;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    //cell 不可选中
    self.tableView.allowsSelection = NO;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
        //移除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    //设置做边距
    self.inputView.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    //一直显示
    self.inputView.leftViewMode = UITextFieldViewModeAlways;
}


//懒加载自动回复
- (NSDictionary *)autoReplay
{
    if (_autoReplay == nil) {
        _autoReplay  = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoReplay.plist" ofType:nil]];
    }
    
    return _autoReplay;
}


//点击右下角的send 按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"-------%@",textField.text);
    
    //1. 发送一条数据
    [self addmessage:textField.text type:ZSRMessageModelGatsby];
    //自动回复
    NSString *autoStr = [self autoReplayWithText:textField.text];
    //将自动回复添加成一天聊天信息
    [self addmessage:autoStr type:ZSRMessageModelJobs];
    //4. 清空表格
    
    self.inputView.text = @"";//nil
    
    
    //直接return yes  即可
    return YES;
}
//自动回复一条聊天信息

- (NSString *)autoReplayWithText:(NSString *)text
{
    //3自动回复
    for (int a = 0 ; a < text.length; a++) {
        
        NSString *subStr = [text substringWithRange:NSMakeRange(a, 1)];
        
        if (self.autoReplay[subStr]) {
            return  self.autoReplay[subStr];
        }
    }
    
    return @"Good!!!";
}

//添加一条聊天信息

- (void)addmessage:(NSString *)text type:(ZSRMessageModelType)type
{
    //1. 添加模型数据
    ZSRMessageModel *msg = [[ZSRMessageModel alloc]init];
    
    //设置数据的值
    NSDate *date = [[NSDate alloc]init];
    NSDateFormatter *dateFt = [[NSDateFormatter alloc]init];
    dateFt.dateFormat = @"HH:mm";
    
    msg.time = [dateFt stringFromDate:date];
    msg.text = text;
    msg.type = type;
    //是否需要隐藏事件
    ZSRMessageFrameModel *lastFm = [self.messages lastObject];
    msg.hideTime = [lastFm.message.time isEqualToString:msg.time];
    //设置内容的frame
    ZSRMessageFrameModel *fm = [[ZSRMessageFrameModel alloc]init];
    //将msg 赋值给 fm 中的message
    fm.message = msg;
    [self.messages addObject:fm];
    
    //2.刷新表格
    [self.tableView reloadData];
    
    
    //3. 自动上移
    //移动的位置
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    //真正去是位置 atSrcollPosition :  滚到位置
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
}

//    UIKeyboardAnimationCurveUserInfoKey = 7;  动画曲线动画
//    UIKeyboardAnimationDurationUserInfoKey = "0.25"; 动画时间
//    UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 216}}"; 键盘bounds
//    UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 588}";  开始键盘的居中位置
//    UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 372}";结束键盘的居中位置
//    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 480}, {320, 216}}"; 键盘开始弹出的frame
//    UIKeyboardFrameChangedByUserInteraction = 0;   键盘改变frame
//    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 264}, {320, 216}}"; 退出键盘的frame

//    UIKeyboardAnimationCurveUserInfoKey = 7;
//    UIKeyboardAnimationDurationUserInfoKey = "0.25";
//    UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 216}}";
//    UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 372}";
//    UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 588}";
//    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 264}, {320, 216}}";
//    UIKeyboardFrameChangedByUserInteraction = 0;
//    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 480}, {320, 216}}";

//当键盘frame 发生改变的时候调用
- (void)keyboardDidChangeFrame:(NSNotification *)noti
{
    NSLog(@"--------%@",noti.userInfo);
    
    //改变window的背景颜色
    self.view.window.backgroundColor = self.tableView.backgroundColor;
    
    //最终键盘的frame
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //键盘实时y
    CGFloat keyY = frame.origin.y;
    
    //屏幕的高度
    CGFloat screenH = [[UIScreen mainScreen] bounds].size.height;
    
    //动画时间
    CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //执行动画
    [UIView animateWithDuration:keyDuration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, keyY - screenH);
    }];
    
}


//当tableview 滚动的时候 结束编辑事件  （退出键盘）
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (NSMutableArray *)messages
{
    if (_messages == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
        NSMutableArray *messageArr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            ZSRMessageModel *message =  [ZSRMessageModel messageWithDict:dict];
            //取出上一个模型
            ZSRMessageFrameModel *lastFm = [messageArr lastObject];
            
            //隐藏时间
            message.hideTime = [message.time isEqualToString:lastFm.message.time];
            
            ZSRMessageFrameModel *fm = [[ZSRMessageFrameModel alloc] init];
            fm.message = message;
            
            [messageArr addObject:fm];

        }
        _messages = messageArr;
    }
    return  _messages;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZSRMessageFrameModel *model = self.messages[indexPath.row];
    return model.cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZSRMessageCell *cell = [ZSRMessageCell messageCellWithTableView:tableView];
    ZSRMessageFrameModel *fm = self.messages[indexPath.row];
    cell.frameMessage = fm;
    return cell;
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end



