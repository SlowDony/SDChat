//
//  SDChatInputView.h
//  SDChat
//
//  Created by Megatron Joker on 2017/5/15.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDChatAddFacekeyBoardView.h" //添加表情
#import "SDChatAddFileKeyBoardView.h"//添加文件view
#define keyBoardDefaultHeight 225 //自定义键盘的高度
@class SDChatInputView;
@protocol SDChatInputViewDelegate <NSObject>

/**
 添加表情

 @param sender 添加表情按钮
 */
-(void)SDChatInputViewAddFaceClicked:(UIButton *)sender;

/**
 添加图片等文件

 @param sender 添加文件按钮
 */
-(void)SDChatInputViewAddFileClicked:(UIButton *)sender;


/**
 发送消息

 @param chatInputView 输入框
 @param textMessage 消息
 */
-(void)SDChatInputView:(SDChatInputView *)chatInputView sendTextMessage:(NSString *)textMessage;


-(void)SDChatInputViewFrameWillChange:(SDChatInputView *)chatInputView ;
@end

@interface SDChatInputView : UIView
@property (nonatomic,strong)UITextView *chatText;

@property (nonatomic,weak) id<SDChatInputViewDelegate>sd_delegate;//




















@end
