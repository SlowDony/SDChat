//
//  SDChatDetail.h
//  SDChat
//
//  Created by Megatron Joker on 2017/5/18.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum: NSUInteger{
    SDChatDetailTypeText, // 文字 0
    SDChatDetailTypeImage, //图片 1
    SDChatDetailTypeAutoReply ,// 自动回复
    SDChatDetailTypeSystemMessages,// 系统消息
    
}SDChatDetailType;
@class SDChatMessage;

@interface SDChatDetail : NSObject

+ (instancetype)sd_chatWith:(SDChatMessage *)chatMsg ;

/**
 文字聊天message
 */
@property (nonatomic,strong)SDChatMessage *chatMsg;

/**
 聊天文字背景图
 */
@property (nonatomic,strong,readonly)UIImage *contectTextBackgroundIma;
@property (nonatomic,strong,readonly)UIImage *contectTextBackgroundHLIma;

/**
 头像url
 */
@property (nonatomic,copy,readonly)NSString *iconHead;
/**
 时间str
 */
@property (nonatomic,copy,readonly)NSString *timeStr;


/**
 姓名
 */
@property (nonatomic,copy,readonly)NSString *nameStr;


/**
 是否显示时间
 */
@property (nonatomic,assign,getter=isShowTime,readonly) BOOL showTime;


/**
 是否显示名字
 */
@property (nonatomic,assign,getter=isMe,readonly)BOOL me;


/**
 是否是患者
 */
@property (nonatomic,assign,getter=isPatient,readonly)BOOL patient;

/**
 聊天类型
 */
@property (nonatomic,assign,readonly)SDChatDetailType chatType;

@end
