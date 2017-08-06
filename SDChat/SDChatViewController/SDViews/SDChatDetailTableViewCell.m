//
//  SDChatDetailTableViewCell.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/17.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatDetailTableViewCell.h"
#import "SDChatDetailFrame.h"
#import "SDChatDetail.h"
#import "SDChatMessage.h"
#import "UIImage+SDResize.h"


@interface SDChatDetailTableViewCell ()

@property (nonatomic,strong)UIButton *iconHeadBtn; //头像

@property (nonatomic,strong)UILabel *timeLab; //  时间标签
@property (nonatomic,strong)UILabel *nameLab; //名字
@end
@implementation SDChatDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellId = @"SDChatDetailTableViewCellID";
    SDChatDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell =[[SDChatDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        [self setupUI];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
-(void)setupUI{
    //时间标签
    UILabel *timelab = [[UILabel alloc] init];
    timelab.backgroundColor = [UIColor clearColor];
    timelab.textColor =fontHightColor;
    timelab.text = @"2012年12月3日 下午12:30";
    timelab.textAlignment = NSTextAlignmentCenter;
    timelab.font = sdTimeFont;
    timelab.numberOfLines = 0;
//    timelab.backgroundColor=[UIColor redColor];
    self.timeLab=timelab;
    [self.contentView addSubview:timelab];
    
    UILabel *namelab = [[UILabel alloc] init];
    namelab.backgroundColor = [UIColor clearColor];
    namelab.textColor =fontHightColor;
    namelab.text = @"";
//    namelab.backgroundColor=[UIColor greenColor];
    namelab.textAlignment = NSTextAlignmentCenter;
    namelab.font = sdNameTextFont;
    namelab.numberOfLines = 0;
    self.nameLab=namelab;
    [self.contentView addSubview:namelab];
    //头像
    UIButton * iconHeadBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [iconHeadBtn  addTarget:self action:@selector(userInfoClick) forControlEvents:UIControlEventTouchUpInside];
    self.iconHeadBtn =iconHeadBtn;
    [self.contentView addSubview: iconHeadBtn];
    //内容
    UIButton * contentBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    contentBtn.titleLabel.font=sdContentTextFont;
    [contentBtn  addTarget:self action:@selector(contentClick) forControlEvents:UIControlEventTouchUpInside];
    self.contentBtn =contentBtn;
    UILongPressGestureRecognizer *longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPressGr.minimumPressDuration = 0.5;
    [contentBtn addGestureRecognizer: longPressGr];

    self.contentBtn.titleLabel.lineBreakMode = 0;
    [self.contentView addSubview: contentBtn];
}
//点击头像获取用户信息
-(void)userInfoClick{
    
}
//点击内容按钮
-(void)contentClick{

    if ([self.sd_delegate respondsToSelector:@selector(SDChatDetailTableViewCellContentClick)]){
        [self.sd_delegate SDChatDetailTableViewCellContentClick];
    }
}
-(void)longPress:(UILongPressGestureRecognizer *)longPressGr{
    SDLog(@"长按");
    if ([self.sd_delegate respondsToSelector:@selector(SDChatDetailTableViewCellLongPress:)]){
        [self.sd_delegate SDChatDetailTableViewCellLongPress:longPressGr];
    }
}
-(void)setChatFrame:(SDChatDetailFrame *)chatFrame{
    _chatFrame=chatFrame;
    SDChatDetail *chat =chatFrame.chat;
    if (chat.chatType ==SDChatDetailTypeSystemMessages)//系统消息
    {
        self.timeLab.text=[NSString stringWithFormat:@"%@ %@",chat.timeStr,chat.chatMsg.msg];
        self.timeLab.textAlignment=NSTextAlignmentLeft;
    }else //其他
    {
        self.timeLab.text=chat.timeStr;
        self.timeLab.textAlignment=NSTextAlignmentCenter;
        [self.iconHeadBtn setBackgroundImage:[UIImage imageNamed:chat.iconHead] forState:UIControlStateNormal];
        [self.contentBtn setBackgroundImage:[UIImage SDResizeWithIma:chat.contectTextBackgroundIma] forState:UIControlStateNormal];
        [self.contentBtn setBackgroundImage:[UIImage SDResizeWithIma:chat.contectTextBackgroundHLIma] forState:UIControlStateHighlighted];
        //    self.contentBtn.backgroundColor=[UIColor redColor];
        
        self.nameLab.text=chat.nameStr;
        if (!chat.patient){
            self.contentBtn.contentEdgeInsets = UIEdgeInsetsMake(sdContentEdgeTop,sdContentEdgeRight , sdContentEdgeBottom,sdContentEdgeLeft );
            self.nameLab.textAlignment=NSTextAlignmentLeft;
            [self.contentBtn setTitleColor:fontBlackColor forState:UIControlStateNormal];
        }else {
            self.nameLab.textAlignment=NSTextAlignmentRight;
            self.contentBtn.contentEdgeInsets = UIEdgeInsetsMake(sdContentEdgeTop, sdContentEdgeLeft, sdContentEdgeBottom, sdContentEdgeRight);
            [self.contentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [self.contentBtn setTitle:chat.chatMsg.msg forState:UIControlStateNormal];
    }
    
}




-(void)layoutSubviews{
    [super layoutSubviews];
    self.timeLab.frame =self.chatFrame.timeFrame;
    self.contentBtn.frame =self.chatFrame.contentFrame;
    self.nameLab.frame =self.chatFrame.nameFrame;
    self.iconHeadBtn.frame =self.chatFrame.iconHeadFrame;
}














@end
