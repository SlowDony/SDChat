//
//  SDChatViewController.m
//  miaohu
//
//  Created by Megatron Joker on 2017/4/7.
//  Copyright © 2017年 SlowDony. All rights reserved.
//
/*
    socket的客户端编程
 1.连接到服务器(ip+port)
 2.监听连接服务器是否成功
 3.如果连接成功,就可以发送消息给服务器
 4.监听服务器转发过来的消息
 
 */

#import "SDChatViewController.h"
#import "SDChatDetailViewController.h"
#import "SDChatTableView.h"
//#import "UIButton+WebCache.h"

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
//1.连接服务器(IP+port.ip+端口号)
//2.监听连接服务器是否成功

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
