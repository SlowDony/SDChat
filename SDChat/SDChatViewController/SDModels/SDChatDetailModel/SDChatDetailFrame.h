//
//  SDChatDetailFrame.h
//  SDChat
//
//  Created by Megatron Joker on 2017/5/18.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <Foundation/Foundation.h>

#define sdTimeFont [UIFont systemFontOfSize:13.0]
#define sdContentTextFont  [UIFont systemFontOfSize:15.0]
#define sdNameTextFont [UIFont systemFontOfSize:10.0]

#define sdContentEdgeTop 20
#define sdContentEdgeLeft 10
#define sdContentEdgeBottom 20
#define sdContentEdgeRight 15
@class SDChatDetail;
@interface SDChatDetailFrame : NSObject

@property (nonatomic,strong)SDChatDetail *chat;
/**
 时间标签
 */
@property (nonatomic,assign,readonly)CGRect timeFrame;
/**
 头像
 */
@property (nonatomic,assign,readonly)CGRect iconHeadFrame;
/**
 名字
 */
@property (nonatomic,assign,readonly)CGRect nameFrame;
/**
 聊天内容
 */
@property (nonatomic,assign,readonly)CGRect contentFrame;
/**
 cell高度
 */
@property (nonatomic,assign,readonly)CGFloat cellH;

@end
