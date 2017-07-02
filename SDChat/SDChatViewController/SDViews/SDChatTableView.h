//
//  SDChatTableView.h
//  SDChat
//
//  Created by Megatron Joker on 2017/5/15.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 对话列表
 */

@protocol SDChatTableViewDelegate <NSObject>

-(void)SDChatTableView:(id)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface SDChatTableView : UITableView
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,weak) id<SDChatTableViewDelegate>sd_delegate;//
@property (nonatomic,strong)NSMutableArray * dataArray;
@end
