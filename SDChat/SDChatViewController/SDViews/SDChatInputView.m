//
//  SDChatInputView.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/15.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatInputView.h"
#import "SDFaceModel.h"

#define inputViewHeight 50
#define defaultTextInputHeight 35
@interface SDChatInputView () <UITextViewDelegate>
@property (nonatomic,strong)UIButton *faceBtn;
@property (nonatomic,strong)UIButton *failBtn;
@property (nonatomic,strong)UIView *bottomline;
@end

@implementation SDChatInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        SDLog("retain count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(self)));
        [self setUI];
        [self addNotification];
    }
    return self;
}

/**
 添加通知(监听选择表情,删除表情,发送表情)
 */
- (void)addNotification
{
    SDLog(@"添加通知");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(faceDidSelected:) name:SDFaceDidSelectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteBtnClicked) name:SDFaceDidDeleteNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessage) name:SDFaceDidSendNotification object:nil];
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

/**
 表情选择通知

 @param notifi notifi
 */
-(void)faceDidSelected:(NSNotification *)notifi{
    
    SDFaceModel *faceModel =notifi.userInfo[SDSelectFaceKey];
     SDLog(@"notifiuserInfo:%@",faceModel.emoji);
    [self.chatText insertText:faceModel.emoji];
    [self.chatText scrollRangeToVisible:NSMakeRange(self.chatText.text.length, 0)];
   
    
}
/**
 删除表情通知
 
 */
-(void)deleteBtnClicked{
    [self.chatText deleteBackward];
}

-(void)setUI{
   
    self.backgroundColor=bjColor;
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 0, SDDeviceWidth, 0.5);
    line.backgroundColor = borderCol;
    [self addSubview:line];
    
    
    UITextView *chatText =[[UITextView alloc]init];
    chatText.frame =CGRectMake(10,(inputViewHeight-defaultTextInputHeight)/2, SDDeviceWidth-101,defaultTextInputHeight);
    chatText.delegate=self;
    chatText.backgroundColor = [UIColor whiteColor];
    chatText.textColor = fontBlackColor;
    chatText.returnKeyType=UIReturnKeySend;
    chatText.textAlignment = NSTextAlignmentLeft;
    chatText.font = [UIFont systemFontOfSize:17];
    self.chatText=chatText;
    chatText.layer.cornerRadius=4;
    chatText.layer.borderColor=borderCol.CGColor;
    chatText.layer.borderWidth=0.8;
    chatText.layer.masksToBounds=YES;
    //观察输入框的高度变化(contentSize)
    [chatText addObserver:self forKeyPath:SDInputViewTextContentSize options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self addSubview:chatText];
    
    //添加表情
    UIButton *faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    faceBtn.frame = CGRectMake(SDDeviceWidth-80 ,(inputViewHeight-30)/2, 30, 30);
//    [faceBtn setTitle:@"表情" forState:UIControlStateNormal];
    [faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFace"] forState:UIControlStateNormal];
    [faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFace_Highlight"] forState:UIControlStateHighlighted];
    [faceBtn  addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.faceBtn=faceBtn;
    faceBtn.tag=1001;
    [self addSubview: faceBtn];
    
    //添加图片
    UIButton *failBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    failBtn.frame = CGRectMake(SDDeviceWidth-30-10,(inputViewHeight-30)/2,30, 30);

    [failBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFile"] forState:UIControlStateNormal];
    [failBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFile_Highlight"] forState:UIControlStateHighlighted];
    failBtn.tag=1002;
    [failBtn  addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.failBtn =failBtn;
    [self addSubview: failBtn];
    
    UIView *bottomline = [[UIView alloc] init];
    bottomline.frame = CGRectMake(0, inputViewHeight-1, SDDeviceWidth, 0.5);
    bottomline.backgroundColor = borderCol;
    self.bottomline =bottomline;
    [self addSubview:bottomline];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    CGFloat oldHeight =[change[@"old"]CGSizeValue].height;
    CGFloat newheight =[change[@"new"]CGSizeValue].height;
    SDLog(@"------new------:%f",newheight);
    SDLog(@"------old------:%f",oldHeight);
    
    if (oldHeight<=0||newheight<=0) return;
    
    if (newheight!=oldHeight) {
        SDLog(@"高度变化");
        if (newheight>100){
            newheight=100;
        }
        
        CGFloat inputHeight = newheight>defaultTextInputHeight ? newheight:defaultTextInputHeight;
        [self chatTextViewHeightFit:inputHeight];
    }
    
    
    
}

-(void)chatTextViewHeightFit:(CGFloat ) height{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame =CGRectMake(0,SDDeviceHeight-(inputViewHeight-defaultTextInputHeight+height), SDDeviceWidth, inputViewHeight-defaultTextInputHeight+height);
        self.chatText.frame =CGRectMake(10,(self.frame.size.height-height)/2, SDDeviceWidth-101,height);
        self.bottomline.frame =CGRectMake(0, self.frame.size.height-1, SDDeviceWidth, 0.5);
        self.faceBtn.frame = CGRectMake(SDDeviceWidth-80 ,(self.frame.size.height-30-10), 30, 30);
        self.failBtn.frame = CGRectMake(SDDeviceWidth-30-10,(self.frame.size.height-30-10),30, 30);
    }];
   
    
}

-(void)setShowFaceBtn:(BOOL)showFaceBtn{
    _showFaceBtn =showFaceBtn;
    if (showFaceBtn){ //显示表情按钮
        [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFace"] forState:UIControlStateNormal];
        [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFace_Highlight"] forState:UIControlStateHighlighted];
    }else { //切换为键盘按钮
        [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddKeyboard"] forState:UIControlStateNormal];
//        [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddkeyboard_Highlight"] forState:UIControlStateHighlighted];
        [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddkeyboard"] forState:UIControlStateHighlighted];
    }
}

-(void)btnClicked:(UIButton *)sender{
    
    if ([self.chatText isFirstResponder])
    {
        [self.chatText resignFirstResponder];
    }
    switch (sender.tag) {
        case 1001: //添加表情view
        {
            
            if([self.sd_delegate respondsToSelector:@selector(SDChatInputViewAddFaceClicked:)]){
                [self.sd_delegate SDChatInputViewAddFaceClicked:sender];
            }
        }
            break;
        case 1002: //添加文件
        {
          
            if([self.sd_delegate respondsToSelector:@selector(SDChatInputViewAddFileClicked:)]){
                [self.sd_delegate SDChatInputViewAddFileClicked:sender];
            }
        }
        default:
            break;
    }
}

- (void) textViewDidChange:(UITextView *)textView
{
    //    CGFloat height = [textView sizeThatFits:CGSizeMake(self.textView.width, MAXFLOAT)].height;
    if (textView.text.length > 5000) { // 限制5000字内
        textView.text = [textView.text substringToIndex:5000];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [self sendMessage];
        return NO;
    }
    return YES;
}

/**
 发送消息
 */
-(void)sendMessage{
    if (self.chatText.text.length > 0) {     // send Text
        if ([self.sd_delegate respondsToSelector:@selector(SDChatInputView:sendTextMessage:)]){
            [self.sd_delegate SDChatInputView:self sendTextMessage:self.chatText.text];
        }
    }
    [self.chatText setText:@""];
}
@end
