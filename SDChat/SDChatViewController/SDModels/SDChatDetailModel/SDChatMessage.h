//
//  SDChatMessage.h
//  SDChat
//
//  Created by Megatron Joker on 2017/5/19.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDChatMessage : NSObject

/**
 消息
 */
@property (nonatomic,strong)NSString *msg;

/**
 消息id
 */
@property (nonatomic,strong)NSString *msgID;

/**
 消息类型
 */
@property (nonatomic,assign)NSUInteger msgType;

/**
 发送时间
 */
@property (nonatomic,strong)NSString *sendTime;

/**
  0患者/1客服
 */
@property (nonatomic,copy)   NSString *sender;


/**
 客服名字
 */
@property (nonatomic,strong) NSString *staffName;

/**
 客服id
 */
@property (nonatomic,strong) NSString *staffID;

-(instancetype)initWithChatMessageDic:(NSDictionary *)dic;
+(instancetype)chatMessageWithDic:(NSDictionary *)dic;
@end
