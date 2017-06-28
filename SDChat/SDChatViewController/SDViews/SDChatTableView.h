//
//  SDChatTableView.h
//  miaohu
//
//  Created by Megatron Joker on 2017/5/15.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 对话列表
 */
@interface SDChatTableView : UITableView
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)NSMutableArray * dataArray;
@end
