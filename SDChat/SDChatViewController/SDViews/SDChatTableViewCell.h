//
//  SDChatTableViewCell.h
//  SDChat
//
//  Created by Megatron Joker on 2017/5/15.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDChat;
@interface SDChatTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

/**
  患者头像
 */
@property (nonatomic,strong)UIImageView *headImage;

/**
 患者姓名
 */
@property (nonatomic,strong)UILabel *titleLabel;

/**
 最后一次聊天内容
 */
@property (nonatomic,strong)UILabel *detailLabel;

/**
 最后一次聊天时间
 */
@property (nonatomic,strong)UILabel *timeLabel;

-(void)setValueWithChatModel:(SDChat *)chat;
@end
