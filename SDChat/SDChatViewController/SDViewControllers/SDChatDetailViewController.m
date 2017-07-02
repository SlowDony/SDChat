//
//  SDChatDetailViewController.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/5.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatDetailViewController.h"

/* 聊天内容模型 */

#import "SDChatMessage.h"
#import "SDChatDetail.h"
#import "SDChatDetailFrame.h"
#import "SDChatDetailTableViewCell.h"
#import "SDChat.h"

/* 聊天内容View */
#import "SDChatInputView.h" //输入view
#import "SDChatAddFileKeyBoardView.h"//添加文件view
#import "SDChatAddFacekeyBoardView.h" //添加表情View
#import "SDChatDetailTableView.h" //列表




#define kInputViewHeight 50

#define kBjViewOriFrame CGRectMake(0, 0, SDDeviceWidth, SDDeviceHeight);


@interface SDChatDetailViewController ()
<

UIGestureRecognizerDelegate,
SDChatInputViewDelegate,
SDChatDetailTableViewLongPress,
UIScrollViewDelegate

>
@property (nonatomic,strong)UITextField *chatTextFiled;
@property (nonatomic,strong)NSMutableArray *dataArr; //消息数据源
@property (nonatomic,strong)SDChatDetailTableView *chatTableView;

/**
 /添加文件view
 */
@property (nonatomic,strong)SDChatAddFileKeyBoardView *addFileView;

/**
 添加表情view
 */
@property (nonatomic,strong)SDChatAddFacekeyBoardView *addFaceView;

/**
 背景view
 */
@property (nonatomic,strong)UIView *bjView;

/**
 *  是否正在切换键盘
 */
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;


/**
 聊天弹出的view
 */
@property (nonatomic,strong)SDChatInputView *chatInputView;


#pragma mark -  列表上啦加载更多
/**
 下拉加载更多
 */
@property (nonatomic,assign) BOOL isRefresh;

/**
 菊花
 */
@property (nonatomic,strong) UIActivityIndicatorView * activity;

/**
 聊天列表加载的小菊花view
 */
@property (nonatomic,strong) UIView *headView;



@end

@implementation SDChatDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}





/**
 下拉加载查看更多的聊天内容网络请求
 */

/*
- (void)setChatNetWorkMoreHistoryMsg{
    
    self.headView.hidden=NO;
    [self.activity startAnimating];
    self.isRefresh =YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        
            //翻转数组
            NSArray* reversedArray=  [[self.dataArr reverseObjectEnumerator] allObjects];
            
            NSMutableArray *emptyArr =[NSMutableArray array];
            for (int i =0; i<reversedArray.count;i++){
                
                NSDictionary *dic =[reversedArray objectAtIndex:i];
                SDChatMessage *msg =[SDChatMessage chatMessageWithDic:dic];
                SDChatDetail *chat =[SDChatDetail sd_chatWith:msg];
                SDChatDetailFrame *chatFrame =[[SDChatDetailFrame alloc]init];
                chatFrame.chat=chat;
                
                [emptyArr addObject:chatFrame];
//                [self.dataArr insertObject:cellFrame atIndex:0];

            }
            [self.dataArr insertObjects:emptyArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, emptyArr.count)]];
            self.headView.hidden=YES;
            
            [self.activity stopAnimating];
            
            if (arr.count==0) {
                self.isRefresh =YES;
                self.headView.frame=CGRectZero;
            }else {
                self.isRefresh =NO;
                self.headView.frame=CGRectMake(0, 0,SDDeviceWidth, 40);
                
            }
            
            self.chatTableView.dataArray =self.dataArr;
            [self.chatTableView reloadData];
        
    });
    
    
}

*/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"会话"];
    [self setUI];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)dataArr{
    if(!_dataArr){
        
        NSArray *arr =@[
                        @{@"msg":@"哈哈",@"msgID":@"1",@"sender":@"0",@"sendTime":@"06-23",@"msgType":@"0"},
                        @{@"msg":@"就是不是搞死你大当家氨",@"msgID":@"2",@"sender":@"1",@"sendTime":@"02:20",@"msgType":@"3"},
                        @{@"msg":@"你在干啥就是不是搞死你大当家氨",@"msgID":@"3",@"sender":@"0",@"sendTime":@"02:30",@"msgType":@"0"},
                        @{@"msg":@"不告诉你就是不是搞死你大当家氨不告诉你就是不是搞死你大当家氨不告诉你就是不是搞死你大当家氨不告诉你就是不是搞死你大当家氨不告诉你就是不是搞死你大当家氨不告诉你就是不是搞死你大当家氨不告诉你就是不是搞死你大当家氨不告诉你就是不是搞死你大当家氨不告诉你就是不是搞死你大当家氨不告诉你就是不是搞死你大当家氨",@"msgID":@"4",@"sender":@"1",@"sendTime":@"02:40",@"msgType":@"0"},
                        @{@"msg":@"不告诉你不告诉你不告诉你不告诉你标题标题标题标题",@"msgID":@"4",@"sender":@"1",@"sendTime":@"02:40",@"msgType":@"0"},
                        @{@"msg":@"不告诉你大手大脚二等奖饿哦我肯定破可怕大卡等奖饿哦我肯定破可怕大卡司",@"msgID":@"4",@"sender":@"0",@"sendTime":@"今天02:40",@"msgType":@"3"},
                       ];
        NSMutableArray *emptyArr =[[NSMutableArray alloc]init];
        
        for (NSDictionary *dic in arr){
            SDChatMessage *msg =[SDChatMessage chatMessageWithDic:dic];
            SDChatDetail *chat =[SDChatDetail sd_chatWith:msg];
            SDChatDetailFrame *chatFrame =[[SDChatDetailFrame alloc]init];
            chatFrame.chat=chat;
            
            [emptyArr addObject:chatFrame];
        }
        _dataArr =[[NSMutableArray alloc]initWithArray:emptyArr];

    }
    return _dataArr;
}

-(UIView *)bjView{
    if(!_bjView){
        _bjView =[[UIView alloc]init];
        _bjView.frame =kBjViewOriFrame;
        _bjView.backgroundColor=[UIColor clearColor];
    }
    return _bjView;
}
-(UIView *)headView{
    if (!_headView){
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SDDeviceWidth, 40)];
        _headView.backgroundColor = [UIColor clearColor];
        self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activity.frame = CGRectMake(_headView.frame.size.width/2, _headView.frame.size.height/2, 20, 20);
        [_headView addSubview:_activity];
        
        _headView.hidden = YES;
    }
    return _headView;
}

-(SDChatDetailTableView *)chatTableView{
    if(!_chatTableView){
        _chatTableView = [[SDChatDetailTableView alloc] initWithFrame:CGRectMake(0, 0, SDDeviceWidth, SDDeviceHeight-kInputViewHeight) style:UITableViewStylePlain];
        
        _chatTableView.sdLongDelegate=self;
        _chatTableView.tableHeaderView = self.headView;
    }
    return _chatTableView;
}
// 输入view
-(SDChatInputView *)chatInputView{
    if (!_chatInputView){
        _chatInputView =[[SDChatInputView alloc]initWithFrame:CGRectMake(0,SDDeviceHeight-kInputViewHeight, SDDeviceWidth, kInputViewHeight)];
        
        _chatInputView.sd_delegate=self;
        
    }
    return _chatInputView;
}
//添加图片view
-(SDChatAddFileKeyBoardView *)addFileView{
    if (!_addFileView){
        _addFileView =[[SDChatAddFileKeyBoardView alloc]init];
        _addFileView.backgroundColor=bjColor;
        _addFileView.width=SDDeviceWidth;
        _addFileView.height=225;
//        _addFileView.frame =kAddFileViewOriFrame;
//        [[UIApplication sharedApplication].keyWindow addSubview:_addFileView];
    }
    return _addFileView;
}

//添加表情view
-(SDChatAddFacekeyBoardView *)addFaceView{
    if (!_addFaceView){
        _addFaceView =[SDChatAddFacekeyBoardView faceKeyBoard];
//        _addFaceView.backgroundColor =[UIColor redColor];
        _addFaceView.width =SDDeviceWidth;
        _addFaceView.height=225;
    }
    return _addFaceView;
}

//1.连接服务器(IP+port.ip+端口号)
//2.监听连接服务器是否成功

-(void)setUI{

    [self.view addSubview:self.bjView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.bjView addSubview:self.chatTableView];
    self.chatTableView.dataArray =self.dataArr;
    [self.chatTableView reloadData];
    [self.bjView addSubview:self.chatInputView];

    SDLog(@"self.bjview.subie:%@",self.bjView.subviews);
//    [self.chatInputView.chatTextFiled becomeFirstResponder];
    //监听键盘弹出
    [self sd_observerKeyboardFrameChange];
//    SDLog(@"addFileViewFrame:%@",NSStringFromCGRect(self.addFileView.frame));
//    SDLog(@"self.view.Frame:%@",NSStringFromCGRect(self.view.frame));
    
}


#pragma mark - SDChatDetailTableViewDelegate
-(void)tableView:(id)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.chatInputView.chatText resignFirstResponder];
    
//    SDLog(@"addFileY:%f",addFileY);

}
-(void)SDChatDetailTableViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<=0  && self.isRefresh==NO)
    {
//        [self setChatNetWorkMoreHistoryMsg];
    }
}

#pragma mark - chatInputViewDelegate

/**
 添加文件按钮监听

 @param sender  添加文件按钮监听
 */
-(void)SDChatInputViewAddFileClicked:(UIButton *)sender{
    SDLog(@"添加图片");
    
    
    self.changingKeyboard = YES;
    if (self.chatInputView.chatText.inputView){
        self.chatInputView.chatText.inputView=nil;
        self.chatInputView.showFaceBtn=YES;
    }else {
        self.chatInputView.chatText.inputView=self.addFileView;
        self.chatInputView.showFaceBtn=NO;
        
    }
    
    // 关闭键盘
    [self.chatInputView.chatText resignFirstResponder];
    self.changingKeyboard = NO;
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.chatInputView.chatText becomeFirstResponder];
        });

}


/**
 添加表情按钮监听

 @param sender 添加表情按钮监听
 */
-(void)SDChatInputViewAddFaceClicked:(UIButton *)sender{
    SDLog(@"添加表情");
//    [self sd_scrollToBottom];
    
    self.changingKeyboard = YES;
    if (self.chatInputView.chatText.inputView){
        self.chatInputView.chatText.inputView=nil;
        self.chatInputView.showFaceBtn=YES;
    }else {
        self.chatInputView.chatText.inputView=self.addFaceView;
        
        self.chatInputView.showFaceBtn=NO;

    }
    
    // 关闭键盘
    [self.chatInputView.chatText resignFirstResponder];
    self.changingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 打开键盘
        [self.chatInputView.chatText becomeFirstResponder];

           });
    
   
    
}
-(void)SDChatInputView:(SDChatInputView *)chatInputView sendTextMessage:(NSString *)textMessage{
   
//    [self setChatNetWorkWith:textMessage];
    int i =arc4random() %2;
    
    NSDictionary *dic =@{@"msg":textMessage,@"msgID":@"1",@"sender":[NSString stringWithFormat:@"%zd",i],@"sendTime":@"06-23",@"msgType":@"0"};
    SDChatMessage *msg =[SDChatMessage chatMessageWithDic:dic];
    SDChatDetail *chat =[SDChatDetail sd_chatWith:msg];
    SDChatDetailFrame *chatFrame =[[SDChatDetailFrame alloc]init];
    chatFrame.chat=chat;
    
    [self.dataArr addObject:chatFrame];
    [self.chatTableView reloadData];
    [self sd_scrollToBottomWithAnimated:YES];
    

}

#pragma mark - textFieldDelegate

-(void)SDChatDetailTableViewLongPress:(UILongPressGestureRecognizer *)longPressGr{
//       [self.chatInputView.chatTextFiled becomeFirstResponder];
}


#pragma mark - 监听键盘弹出方法
- (void)sd_observerKeyboardFrameChange
{
    
    [[NSNotificationCenter defaultCenter] addObserverForName: UIKeyboardWillChangeFrameNotification
                                                      object:nil
                                                       queue: [NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                      //
                                                      //                                                      NSLog(@"%s, line = %d,note =%@", __FUNCTION__, __LINE__, note);
                                                      /**
                                                       note.userInfo
                                                       UIKeyboardAnimationCurveUserInfoKey = 7;
                                                       UIKeyboardAnimationDurationUserInfoKey = "0.25";
                                                       UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
                                                       UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
                                                       UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
                                                       UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
                                                       UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
                                                       UIKeyboardIsLocalUserInfoKey = 1;
                                                       self.view 可以根据 end.oriY来进行 布局改变
                                                       */
                                                      
                                                      [self sd_scrollToBottomWithAnimated:YES];
//                                                      SDLog(@"键盘之前bjView:%@",NSStringFromCGRect(self.bjView.frame));
//                                                      SDLog(@"键盘之前View:%@",NSStringFromCGRect(self.view.frame));
                                                      CGFloat endY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
                                                      CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
                                                      
                                                      
                                                      CGRect bjViewFrame =self.bjView.frame;
                                                      bjViewFrame.origin.y =endY - bjViewFrame.size.height;
                                                      self.bjView.frame=bjViewFrame;
                                                      
                                                      SDLog(@"键盘之后View:%@",NSStringFromCGRect(self.view.frame));
                                                      
                                                      [UIView animateWithDuration:duration animations:^{
                                                          [self.view setNeedsLayout];
                                                      }];
                                                      
                                                      
                                                  }];
}
- (void)sd_scrollToBottomWithAnimated:(BOOL)animate
{
    if (!self.dataArr.count) return;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow: self.dataArr.count - 1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath: lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:animate];
}

#pragma mark -右按钮


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
