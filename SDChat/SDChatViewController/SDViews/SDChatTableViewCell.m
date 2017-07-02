//
//  SDChatTableViewCell.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/15.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatTableViewCell.h"

#import "SDChat.h"
@implementation SDChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellId = @"SDChatTableViewCellId";
    SDChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell =[[SDChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    //头像
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.frame = CGRectMake(10, 10, 50, 50);
    self.headImage=headImage;
    [self addSubview:headImage];
    //标题昵称
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(70, 10, SDDeviceWidth-90-70, 25);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor =fontBlackColor;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.numberOfLines = 0;
    self.titleLabel=titleLabel;
    [self addSubview:titleLabel];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.frame = CGRectMake(70, 35, SDDeviceWidth-100, 25);
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.textColor =fontHightColor;
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.numberOfLines = 0;
    self.detailLabel=detailLabel;
    [self addSubview:detailLabel];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(SDDeviceWidth-90, 10,80, 25);
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor =fontHightColor;
    timeLabel.text = @"2017/02/02";
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textAlignment=NSTextAlignmentRight;
    timeLabel.numberOfLines = 0;
    self.timeLabel=timeLabel;
    [self addSubview:timeLabel];
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.frame = CGRectMake(SDDeviceWidth-35,40,20,15);
    numLabel.backgroundColor = [UIColor redColor];
    numLabel.textColor =[UIColor whiteColor];
    int num =arc4random() % 2;
    if (num ==0){
        numLabel.hidden=YES;
    }else {
        numLabel.hidden=NO;
    }
    
    numLabel.text =[NSString stringWithFormat:@"%zd",num];
    numLabel.font = [UIFont systemFontOfSize:10];
    numLabel.textAlignment=NSTextAlignmentCenter;
    numLabel.numberOfLines = 0;
    numLabel.layer.cornerRadius=7.5;
    numLabel.layer.masksToBounds=YES;
    [self addSubview:numLabel];
    
    
}

-(void)setValueWithChatModel:(SDChat *)chat{
    
    self.headImage.image = [UIImage imageNamed:@"chatHead"];

    if (chat.isONLine) //在线
    {
        self.headImage.alpha=1;
    }else //离线
    {
        self.headImage.alpha=0.2;
    }
    self.titleLabel.text=chat.nickName;
    self.detailLabel.text=chat.lastMsg;
    self.timeLabel.text =chat.sendTime;
}
@end
