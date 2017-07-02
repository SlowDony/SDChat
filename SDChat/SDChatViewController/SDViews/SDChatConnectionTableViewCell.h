//
//  SDChatConnectionTableViewCell.h
//  SDChat
//
//  Created by Megatron Joker on 2017/5/17.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDChatConnectionTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)UIView *pointView;
@property (nonatomic,strong)UIImageView *headImage;
@property (nonatomic,strong)UILabel *numLab;
@property (nonatomic,strong)UILabel *titleLab;
@end
