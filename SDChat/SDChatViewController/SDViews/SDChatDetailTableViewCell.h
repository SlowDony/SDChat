//
//  SDChatDetailTableViewCell.h
//  SDChat
//
//  Created by Megatron Joker on 2017/5/17.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDChatDetailTableViewCellLongPressDelegate <NSObject>

-(void)SDChatDetailTableViewCellLongPress:(UILongPressGestureRecognizer *)longPressGr;
-(void)SDChatDetailTableViewCellContentClick;
@end
@class SDChatDetailFrame;
@interface SDChatDetailTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;


/**
 cellFrame
 */
@property (nonatomic, strong) SDChatDetailFrame *chatFrame;
@property (nonatomic,strong)UIButton *contentBtn; //聊天内容

@property (nonatomic,weak) id<SDChatDetailTableViewCellLongPressDelegate>sd_delegate;
@end
