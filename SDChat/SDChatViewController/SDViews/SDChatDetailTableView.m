//
//  SDChatDetailTableView.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/17.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatDetailTableView.h"
#import "SDChatDetailTableViewCell.h"
#import "SDChatDetailFrame.h"
#import "SDChatDetail.h"
#import "SDChatMessage.h"

@interface SDChatDetailTableView ()
<SDChatDetailTableViewCellLongPressDelegate>
{
    UIMenuItem * copyMenuItem; //复制
    UIMenuItem * deleteMenuItem; //删除
    NSIndexPath *longIndexPath;
}
@end
@implementation SDChatDetailTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self =[super initWithFrame:frame style:style];
    if (self) {
        self.dataSource=self;
        self.delegate=self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}
#pragma mark ----------UITabelViewDataSource----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDChatDetailTableViewCell *cell =[SDChatDetailTableViewCell cellWithTableView:self];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    SDChatDetailFrame *chatFrame =self.dataArray[indexPath.row];
    cell.chatFrame=chatFrame;
    
    cell.sd_delegate =self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.sdLongDelegate respondsToSelector:@selector(SDChatDetailTableView:didSelectRowAtIndexPath:)]){
        [self.sdLongDelegate SDChatDetailTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -SDChatDetailTableViewCellDelegate
-(void)SDChatDetailTableViewCellLongPress:(UILongPressGestureRecognizer *)longRecognizer{
//    SDLog(@"长按longRecognizer%ld,%ld",longRecognizer.state,UIGestureRecognizerStateBegan);
    CGPoint location       = [longRecognizer locationInView:self];
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:location];
    longIndexPath         = indexPath;
    id object              = [self.dataArray objectAtIndex:indexPath.row];
    if (![object isKindOfClass:[SDChatDetailFrame class]]) return;
    SDChatDetailTableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    if (longRecognizer.state == UIGestureRecognizerStateBegan){
        [self showMenuViewController:cell.contentBtn andIndexPath:indexPath message:cell.chatFrame.chat];
    }
    
    if ([self.sdLongDelegate respondsToSelector:@selector(SDChatDetailTableViewLongPress:)]){
        [self.sdLongDelegate SDChatDetailTableViewLongPress:longRecognizer];
    }
    
}
- (void)showMenuViewController:(UIView *)showInView andIndexPath:(NSIndexPath *)indexPath message:(SDChatDetail *)chat
{
   [self becomeFirstResponder];
    if (copyMenuItem   == nil) {
        copyMenuItem   = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyMessage:)];
    }
    if (deleteMenuItem == nil) {
        deleteMenuItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteMessage:)];
    }
    
    UIMenuController *menu =[UIMenuController sharedMenuController];
    [menu setMenuItems:@[copyMenuItem,deleteMenuItem]];
    [menu setTargetRect:showInView.frame inView:showInView.superview];
    [menu setMenuVisible:YES animated:YES];
    

}

- (void)copyMessage:(UIMenuItem *)copyMenuItem
{
    UIPasteboard *pasteboard  = [UIPasteboard generalPasteboard];
    SDChatDetailFrame * detailFrame = [self.dataArray objectAtIndex:longIndexPath.row];
    pasteboard.string         = detailFrame.chat.chatMsg.msg;
}

- (void)deleteMessage:(UIMenuItem *)deleteMenuItem
{
    // 这里还应该把本地的消息附件删除
    SDChatDetailFrame * detailFrame = [self.dataArray objectAtIndex:longIndexPath.row];
    [self statusChanged:detailFrame];
}
- (void)statusChanged:(SDChatDetailFrame *)detailFrame
{
    [self.dataArray removeObject:detailFrame];
    [self beginUpdates];
    [self deleteRowsAtIndexPaths:@[longIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self endUpdates];
}
//处理action事件
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if(action == @selector(copyMessage:)){
        return YES;
    
    } else if (action == @selector(deleteMessage:)){
        return YES;
    }else {
        return [super canPerformAction:action withSender:sender];

    }
    
}
-(BOOL)canBecomeFirstResponder{
    return YES;
  
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UIMenuController * menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
}

-(void)SDChatDetailTableViewCellContentClick{
    SDLog(@"点击按钮");
    UIMenuController * menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];

}
#pragma mark ----------UITabelViewDelegate----------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray[indexPath.row] cellH];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    if (scrollView.contentOffset.y<=0  && _isRefresh==NO)
//    {
//       // [self setChatNetWorkMoreHistoryMsg];
//    }
    if ([self.sdLongDelegate respondsToSelector:@selector(SDChatDetailTableViewDidScroll:)]) {
        [self.sdLongDelegate SDChatDetailTableViewDidScroll:scrollView];
    }
}
/**
 重写contentSize

 @param contentSize 监听tableView滚动
 */
- (void)setContentSize:(CGSize)contentSize
{
    if (!CGSizeEqualToSize(self.contentSize, CGSizeZero))
    {
        if (contentSize.height > self.contentSize.height)
        {
            CGPoint offset = self.contentOffset;
            offset.y += (contentSize.height - self.contentSize.height);
            self.contentOffset = offset;
        }
    }
    [super setContentSize:contentSize];
}
@end
