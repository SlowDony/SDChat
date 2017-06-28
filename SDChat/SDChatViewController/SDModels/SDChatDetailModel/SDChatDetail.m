//
//  SDChatDetail.m
//  miaohu
//
//  Created by Megatron Joker on 2017/5/18.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatDetail.h"
#import "SDChatMessage.h"
@interface SDChatDetail()



/** 文字聊天内容 */
@property (nonatomic, copy) NSString *contentText;
/**
 聊天文字背景图
 */
@property (nonatomic,strong)UIImage *contectTextBackgroundIma;
@property (nonatomic,strong)UIImage *contectTextBackgroundHLIma;


/**
 头像url
 */
@property (nonatomic,copy)NSString *iconHead;


/**
 时间str
 */
@property (nonatomic,copy)NSString *timeStr;


/**
 姓名
 */
@property (nonatomic,copy)NSString *nameStr;


/**
 是否显示时间
 */
@property (nonatomic,assign,getter=isShowTime) BOOL showTime;


/**
 是否显示名字
 */
@property (nonatomic,assign,getter=isMe)BOOL me;


/**
 是否是患者
 */
@property (nonatomic,assign,getter=isPatient)BOOL patient;

/**
 聊天类型
 */
@property (nonatomic,assign)SDChatDetailType chatType;
@end

@implementation SDChatDetail
+ (instancetype)sd_chatWith:(SDChatMessage *)chatMsg {
    SDChatDetail *chat =[[self alloc]init];
    chat.chatMsg=chatMsg;
    return chat;
}

-(void)setChatMsg:(SDChatMessage *)chatMsg{
    _chatMsg =chatMsg;
    self.patient=[chatMsg.sender boolValue];
    if (!self.patient) { //0患者1客服
        self.iconHead = @"myHead";
        self.contectTextBackgroundIma = [UIImage imageNamed: @"chatSickMessage_Normal"];
        self.contectTextBackgroundHLIma = [UIImage imageNamed: @"chatSickMessage_Highlighted"];
        self.timeStr=chatMsg.sendTime;
        self.nameStr=@"slowdony";
        self.me=NO;
    }else {
        
        self.iconHead = @"chatHead";
        self.contectTextBackgroundIma = [UIImage imageNamed: @"chatMyMessage_Normal"];
        self.contectTextBackgroundHLIma = [UIImage imageNamed: @"chatMyMessage_Highlighted"];
        self.timeStr=chatMsg.sendTime;
        self.me=YES;
        self.nameStr =@"";
        
    }
    self.timeStr=chatMsg.sendTime;
    self.contentText=chatMsg.msg;
    self.showTime=YES;
    self.chatType=chatMsg.msgType;

    
}

@end
