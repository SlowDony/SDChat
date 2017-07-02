//
//  SDChat.m
//  SDChat
//
//  Created by slowdony on 2017/6/20.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChat.h"

@implementation SDChat

-(instancetype)initChatWithDic:(NSDictionary *)dic{
    self =[super init];
    if(self){
        
        self.nickName =dic[@"nickName"]; //昵称
        self.lastMsg=dic[@"lastMsg"]; //最后一句聊天
        self.headImage =dic[@""]; //头像
        self.sendTime=dic[@"sendTime"] ; //最后时间
        self.badge =[dic[@""] intValue]; //未读消息
        self.nickNameID=dic[@"nickNameID"]; //VisterID访客ID
        
    }
    return self;
}

+(instancetype)chatWithDic:(NSDictionary *)dic{
    return [[self alloc]initChatWithDic:dic];
}

-(void)setIsONLine:(BOOL )isONLine{
    _isONLine=isONLine;
}

@end
