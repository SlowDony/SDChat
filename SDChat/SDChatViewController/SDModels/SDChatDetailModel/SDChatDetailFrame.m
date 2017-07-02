//
//  SDChatDetailFrame.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/18.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatDetailFrame.h"
#import "SDChatMessage.h"
#import "SDChatDetail.h"

@interface SDChatDetailFrame ()


/**
 时间标签
 */
@property (nonatomic,assign)CGRect timeFrame;
/**
 头像
 */
@property (nonatomic,assign)CGRect iconHeadFrame;
/**
 名字
 */
@property (nonatomic,assign)CGRect nameFrame;
/**
 聊天内容
 */
@property (nonatomic,assign)CGRect contentFrame;
/**
 cell高度
 */
@property (nonatomic,assign)CGFloat cellH;

@end

@implementation SDChatDetailFrame
-(void)setChat:(SDChatDetail *)chat{
    _chat=chat;
    CGFloat screenW =CGRectGetWidth([UIScreen mainScreen].bounds);
    
    CGFloat margin =10;
    
    if (chat.chatType==SDChatDetailTypeSystemMessages) //消息类型位系统消息
    {
        
        
        CGFloat timeX ;
        CGFloat timeY =margin;
        CGFloat timeW ;
        CGFloat timeH ;
        
        
        
        CGFloat timeStrMaxW =screenW-50;
        NSString *systemMessage =[NSString stringWithFormat:@"%@ %@",chat.timeStr,chat.chatMsg.msg];
        
        CGSize timeStrSize =[systemMessage boundingRectWithSize:
                                CGSizeMake(timeStrMaxW-sdContentEdgeLeft-sdContentEdgeRight, CGFLOAT_MAX)
                                                              options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                           attributes:
                                @{NSFontAttributeName :sdTimeFont}
                                                              context:
                                nil].size;
        //时间的宽度
        CGFloat timeStrW =timeStrSize.width+sdContentEdgeLeft+sdContentEdgeRight;
        
        
        timeW =timeStrMaxW<timeStrW?timeStrMaxW:timeStrW;
        
        timeX =(screenW-timeW)/2;
        
        timeH =timeStrMaxW<timeStrW?timeStrSize.height+sdContentEdgeTop+sdContentEdgeBottom:timeStrSize.height+sdContentEdgeTop;
        
        self.timeFrame =CGRectMake(timeX, timeY, timeW, timeH);

        
        
        self.iconHeadFrame = CGRectZero;
        self.contentFrame = CGRectZero;
        self.nameFrame=CGRectZero;
        self.cellH =timeH+margin;
     
    }else  //其他消息
    {
    
        CGFloat timeX =0;
        CGFloat timeY =margin;
        CGFloat timeW =screenW;
        CGFloat timeH =chat.isShowTime ?20:0;
        self.timeFrame =CGRectMake(timeX, timeY, timeW, timeH);

        CGFloat iconHeadX ;
        CGFloat iconHeadY =CGRectGetMaxY(self.timeFrame);
        CGFloat iconHeadW =44;
        CGFloat iconHeadH =iconHeadW;
        
        CGFloat nameX ;
        CGFloat nameY =iconHeadY;
        CGFloat nameW =screenW -2*(margin*2+iconHeadW);
        CGFloat nameH =chat.isMe ?0:15;
        
        CGFloat contentX ;
        CGFloat contentY =iconHeadY+nameH;
        CGFloat contentW = 0.0 ;
        CGFloat contentH = 0.0 ;
        switch (chat.chatType) {
            case SDChatDetailTypeText:
            {
                
                CGFloat contentMaxW =screenW -2*(margin*2+iconHeadW);
                
                CGSize contentStrSize =[chat.chatMsg.msg boundingRectWithSize:
                                        CGSizeMake(contentMaxW-sdContentEdgeLeft-sdContentEdgeRight, CGFLOAT_MAX)
                                                                      options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                                   attributes:
                                        @{NSFontAttributeName :sdContentTextFont}
                                                                      context:
                                        nil].size;
                //字体的宽度
                CGFloat contentStrW =contentStrSize.width+sdContentEdgeLeft+sdContentEdgeRight;
                
                if (contentStrW<55.5){
                    contentW=55.5;
                }else {
                    contentW =contentMaxW<contentStrW?contentMaxW:contentStrW;
                    
                }
                contentH =contentMaxW<contentStrW?contentStrSize.height+sdContentEdgeTop+sdContentEdgeBottom:contentStrSize.height+sdContentEdgeTop;
                //            DLog(@"contentW:%f *****contentH:%f*****contentStrSize:%@",contentW,contentH,NSStringFromCGSize(contentStrSize));
                
            }
                break;
            case SDChatDetailTypeImage:
            {
                
                contentW =200;
                contentH =100;
            }
                break;
           
            case SDChatDetailTypeSystemMessages: //系统消息
            {
                
                contentW =200;
                contentH =100;
            }
                break;
            default:
                break;
        }
        //是否是患者
        if(!chat.isPatient) //0患者1客服
        {
            iconHeadX=margin;
            contentX=iconHeadX+iconHeadW+margin;
            nameX=contentX+5;
        }else {
            iconHeadX=screenW-margin-iconHeadW;
            contentX=screenW-margin-iconHeadW-contentW-margin;
            nameX=margin+iconHeadW+margin-5;

        }
        
        self.iconHeadFrame = CGRectMake(iconHeadX,iconHeadY, iconHeadW, iconHeadH);
        self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
        self.nameFrame=CGRectMake(nameX, nameY, nameW, nameH);
        
        self.cellH =(contentH>iconHeadH)? CGRectGetMaxY(self.contentFrame)+margin:CGRectGetMaxY(self.iconHeadFrame)+margin+10;
        
        
    }
    
    
    
    
    
    
    
}

@end
