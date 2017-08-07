//
//  SDChatViewController.m
//  SDChat
//
//  Created by Megatron Joker on 2017/4/7.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

/*
    
 目前实现
 
 基本聊天对话业务,
 聊天对话UI布局,
 表情键盘弹出,
 支持emoji表情.
 待完成
 
 图文混排,
 表情键盘弹出的优化,
 支持png格式表情,
 拍照上传图片.
 未来
 
 完善SDChat
 我的邮箱:devslowdony@gmail.com
 项目更新地址 GitHub:https://github.com/SlowDony/SDChat
 如果有好的建议或者意见 ,欢迎指出 , 您的支持是对我最大的鼓励,谢谢. 求STAR ..😆
 */

#import "SDChatViewController.h"
#import "SDChatDetailViewController.h"
#import "SDChatTableView.h"


#import "SDChat.h" //聊天对话模型


@interface SDChatViewController ()
<
SDChatTableViewDelegate
>
/**
 总数据源
 */
@property (nonatomic,strong)NSMutableArray *dataArr; //消息数据源

@property (nonatomic,strong)SDChatTableView *chatTableView;


@end

@implementation SDChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self setTitle:@"对话"];
    NSArray *arr =@[@"haha",@"哦哦",@"营业"];
    SDLog(@"arr:%@",arr);
    [self setUI];
    
    
    NSMutableArray *emptyArr =[[NSMutableArray alloc]init];
    for (NSDictionary *dict in self.dataArr){
        SDChat *chat =[SDChat chatWithDic:dict];
        chat.isONLine =YES;
        [emptyArr addObject:chat];
        
    }
        self.chatTableView.dataArray =emptyArr;
        
        [self.chatTableView reloadData];
    




    // Do any additional setup after loading the view.


}


/**
 总数据源

 @return 总数据
 */
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        
        NSArray *arr =@[
                        @{@"nickName":@"slowdony",@"lastMsg":@"哈哈",@"sendTime":@"06/06",@"nickNameID":@"1"},
                        @{@"nickName":@"danny",@"lastMsg":@"[图片]",@"sendTime":@"06/07",@"nickNameID":@"1"},
                        ];
        _dataArr =[[NSMutableArray alloc]initWithArray:arr];
    }
    return _dataArr;
}




-(SDChatTableView *)chatTableView{
    if(!_chatTableView){
        _chatTableView = [[SDChatTableView alloc] initWithFrame:CGRectMake(0, 0, SDDeviceWidth, SDDeviceHeight-64-44) style:UITableViewStylePlain];
        _chatTableView.tableFooterView =[UIView new];
        _chatTableView.sd_delegate=self;

    }
    return _chatTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


-(void)setUI{
    
    [self.view addSubview:self.chatTableView];
  
}

-(void)SDChatTableView:(id)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SDChatDetailViewController *v =[[SDChatDetailViewController alloc]init];
    
    
    SDChat  *chat =self.dataArr[indexPath.row];
    v.chat =chat;
    [self.navigationController pushViewController:v animated:YES];
}








/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
