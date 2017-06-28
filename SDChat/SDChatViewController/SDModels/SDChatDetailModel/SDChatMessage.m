//
//  SDChatMessage.m
//  miaohu
//
//  Created by Megatron Joker on 2017/5/19.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatMessage.h"

@implementation SDChatMessage

-(instancetype)initWithChatMessageDic:(NSDictionary *)dic{
    self =[super init];
    if (self){
        self.msg=dic[@"MESSAGE"]; //消息
        self.msgID=dic[@"ID"]; //消息id
        self.sender=dic[@"SENDER"]; //1是客服 /0患者
        self.sendTime=dic[@"SENDER"];
        self.msgType=[dic[@"TYPE"] integerValue]; //消息类型
        self.staffName =dic[@"STAFF_NAME"];  //客服名字
        self.staffID =dic[@"HOSPITAL_STAFF_ID"]; //客服id
    }
    return self;
}
+(instancetype)chatMessageWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithChatMessageDic:dic];
}
@end
