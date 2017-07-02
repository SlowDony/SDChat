//
//  SDChat.h
//  SDChat
//
//  Created by slowdony on 2017/6/20.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 聊天模型
 */
@interface SDChat : NSObject

/**
 昵称
 */
@property (nonatomic,strong)NSString *nickName;

/**
 最后一句消息
 */
@property (nonatomic,strong)NSString *lastMsg;

/**
 访客id
 */
@property (nonatomic,strong)NSString *nickNameID;


/**
 发送时间
 */
@property (nonatomic,strong)NSString *sendTime;

/**
 发送消息未读数
 */
@property (nonatomic,assign)NSInteger badge;



/**
 患者头像
 */
@property (nonatomic,strong)NSString *headImage;



/**
 是否在线(0离线1在线);
 */
@property (nonatomic,assign)BOOL isONLine;



-(instancetype)initChatWithDic:(NSDictionary *)dic;
+(instancetype)chatWithDic:(NSDictionary *)dic;
@end
