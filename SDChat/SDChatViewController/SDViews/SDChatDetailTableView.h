//
//  SDChatDetailTableView.h
//  SDChat
//
//  Created by Megatron Joker on 2017/5/17.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 对话内容列表
 */
@protocol SDChatDetailTableViewLongPress <NSObject>

-(void)SDChatDetailTableViewLongPress:(UILongPressGestureRecognizer *)longPressGr;
-(void)SDChatDetailTableViewDidScroll:(UIScrollView *)scrollView;
-(void)SDChatDetailTableView:(id)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SDChatDetailTableView : UITableView
<UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic,weak) id<SDChatDetailTableViewLongPress>sdLongDelegate;//长按代理


@property (nonatomic,strong)NSMutableArray * dataArray;
@end
