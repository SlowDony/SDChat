//
//  SDChatInputView.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/15.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatInputView.h"
#import "SDFaceModel.h"

static CGFloat systemkeyBoardHeight = 0;
static CGFloat inputViewDefaultHeight =50; //输入框默认高度
static CGFloat chatTextInputHeight  =35; //默认输入框的高度

@interface SDChatInputView () <UITextViewDelegate>

//记录系统键盘和自定义键盘高度



@property (nonatomic,strong)UIButton *faceBtn;
@property (nonatomic,strong)UIButton *failBtn;
@property (nonatomic,strong)UIView *bottomline;

/**
 添加表情view
 */
@property (nonatomic,strong)SDChatAddFacekeyBoardView *addFaceView;

/**
 /添加文件view
 */
@property (nonatomic,strong)SDChatAddFileKeyBoardView *addFileView;



/**
 键盘容器(存放表情键盘和上传文件view)
 */

@property (nonatomic,strong)UIView *keyBoardContainer ;


/**
 输入框容器,(存放输入框,添加表情按钮和添加表情按钮)
 */
@property (nonatomic,strong)UIView *inputViewContainer;



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
//        SDLog("retain count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(self)));
        SDLog(@"self.frame =:%@",NSStringFromCGRect(self.frame));
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SDFaceDidSendNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SDFaceDidDeleteNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SDFaceDidSendNotification object:nil];
     [self.chatText removeObserver:self forKeyPath:SDInputViewTextContentSize];

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


/**
 系统键盘弹起通知

 */
-(void)systemKeyboardWillShow:(NSNotification *)notification{
    
    //获取键盘的高度
    CGFloat systemKeyBoardHeight =[notification.userInfo[@"UIKeyboardBoundsUserInfoKey"]CGRectValue].size.height;
    //记录系统键盘的高度
    systemkeyBoardHeight =systemKeyBoardHeight;
    
    //当前的chatInputView高度
    CGFloat inputViewHeight =CGRectGetHeight(self.inputViewContainer.frame);
    //将自定义键盘位移
    [self customKeyboardMove:SDDeviceHeight -systemKeyBoardHeight-inputViewHeight];
    [self reloadInputViewBtnStateDefault];
}


/**
 键盘降落

 @param notification 通知
 */
-(void)keyboardResignFirstResponder:(NSNotification *)notification{
    [self.chatText resignFirstResponder];
    //按钮初始化刷新
    //    [self reloadSwitchButtons];
    [self customKeyboardMove:SDDeviceHeight - inputViewDefaultHeight];
   
}
/**
 表情/添加键盘的容器
 */
-(UIView *)keyBoardContainer{
    if (!_keyBoardContainer) {
        _keyBoardContainer =[[UIView alloc]init];
        _keyBoardContainer.frame =CGRectMake(0, inputViewDefaultHeight, SDDeviceWidth, keyBoardDefaultHeight);
        [_keyBoardContainer addSubview:self.addFaceView];
        [_keyBoardContainer addSubview:self.addFileView];
        
    }
    return _keyBoardContainer;
}

/**
 输入框容器
 */
-(UIView *)inputViewContainer{
    if (!_inputViewContainer){
        _inputViewContainer =[[UIView alloc]init];
        _inputViewContainer.frame =CGRectMake(0,0,SDDeviceWidth, inputViewDefaultHeight);
        
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(0, 0, SDDeviceWidth, 0.5);
        line.backgroundColor = borderCol;
        [_inputViewContainer addSubview:line];
        [_inputViewContainer addSubview:self.chatText];
        [_inputViewContainer addSubview:self.faceBtn];
        [_inputViewContainer addSubview:self.failBtn];
        //添加图片
        UIView *bottomline = [[UIView alloc] init];
        bottomline.frame = CGRectMake(0, inputViewDefaultHeight-1, SDDeviceWidth, 0.5);
        bottomline.backgroundColor = borderCol;
        self.bottomline =bottomline;
        [_inputViewContainer addSubview:bottomline];
        
    }
    return _inputViewContainer;
}
/**
 添加表情view
 */

-(SDChatAddFacekeyBoardView *)addFaceView{
    if (!_addFaceView){
        _addFaceView =[SDChatAddFacekeyBoardView faceKeyBoard];
        //        _addFaceView.backgroundColor =[UIColor redColor];
        _addFaceView.width =SDDeviceWidth;
        _addFaceView.height=225;
    }
    return _addFaceView;
}

//添加图片view
-(SDChatAddFileKeyBoardView *)addFileView{
    if (!_addFileView){
        _addFileView =[[SDChatAddFileKeyBoardView alloc]init];
        _addFileView.backgroundColor=bjColor;
        _addFileView.width=SDDeviceWidth;
        _addFileView.height=225;
    }
    return _addFileView;
}

//聊天输入框
-(UITextView *)chatText{
    if (!_chatText) {
        _chatText =[[UITextView alloc]init];
        _chatText.frame =CGRectMake(10,(inputViewDefaultHeight-chatTextInputHeight)/2, SDDeviceWidth-101,chatTextInputHeight);
        _chatText.delegate=self;
        _chatText.backgroundColor = [UIColor whiteColor];
        _chatText.textColor = fontBlackColor;
        _chatText.returnKeyType=UIReturnKeySend;
        _chatText.enablesReturnKeyAutomatically = YES;
        
        _chatText.textAlignment = NSTextAlignmentLeft;
        _chatText.font = [UIFont systemFontOfSize:17];
        
        _chatText.layer.cornerRadius=4;
        _chatText.layer.borderColor=borderCol.CGColor;
        _chatText.layer.borderWidth=0.8;
        _chatText.layer.masksToBounds=YES;
        //观察输入框的高度变化(contentSize)
       [_chatText addObserver:self forKeyPath:SDInputViewTextContentSize options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        

    }
    return _chatText;
}

/**
 添加表情
 */
-(UIButton *)faceBtn{
    if(!_faceBtn){
        
        _faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _faceBtn.frame = CGRectMake(SDDeviceWidth-80 ,(inputViewDefaultHeight-30)/2, 30, 30);
        [_faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFace"] forState:UIControlStateNormal];
        [_faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFace_Highlight"] forState:UIControlStateHighlighted];
        //    [_faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddKeyboard"] forState:UIControlStateSelected];
        [_faceBtn  addTarget:self action:@selector(faceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _faceBtn.tag=1001;
      
    }
    return _faceBtn;
}


/**
 添加图片.等文件
 */
-(UIButton *)failBtn{
    if (!_failBtn){
        _failBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _failBtn.frame = CGRectMake(SDDeviceWidth-30-10,(inputViewDefaultHeight-30)/2,30, 30);
        
        [_failBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFile"] forState:UIControlStateNormal];
        [_failBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFile_Highlight"] forState:UIControlStateHighlighted];
        _failBtn.tag=1002;
        [_failBtn  addTarget:self action:@selector(failBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _failBtn;
}
-(void)setUI{
   
    self.backgroundColor=bjColor;
//  输入框
    [self addSubview:self.inputViewContainer];
//   表情键盘
    [self addSubview:self.keyBoardContainer];
    //重置表情
    [self reloadInputViewBtnStateDefault];
}

-(void)reloadInputViewBtnStateDefault{
    self.faceBtn.selected=NO;
    self.failBtn.selected=NO;
    [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFace"] forState:UIControlStateNormal];
    [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFace_Highlight"] forState:UIControlStateHighlighted];
    
}

/**
 观察输入框的高度变化
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    CGFloat oldHeight =[change[@"old"]CGSizeValue].height;
    CGFloat newheight =[change[@"new"]CGSizeValue].height;
    
    if (oldHeight<=0||newheight<=0) return;
    
    if (newheight!=oldHeight) {

        if (newheight>100){
            newheight=100;
        }
        
        CGFloat inputHeight = newheight>chatTextInputHeight ? newheight:chatTextInputHeight;
        SDLog(@"inputHeight:%f",inputHeight);
        
        [self chatTextViewHeightFit:inputHeight];
    }
}

-(void)chatTextViewHeightFit:(CGFloat ) height{
    
    [UIView animateWithDuration:0.3 animations:^{
        
       
        SDLog(@" self.frame:%@",NSStringFromCGRect(self.frame));
        
        CGFloat inputH =height+inputViewDefaultHeight-chatTextInputHeight;
        
        self.inputViewContainer.frame =CGRectMake(0, 0, SDDeviceWidth,inputH);
        
        
        self.chatText.frame =CGRectMake(10,(inputH-height)/2, SDDeviceWidth-101,height);
        self.bottomline.frame =CGRectMake(0, inputH-1, SDDeviceWidth, 0.5);
        self.faceBtn.frame = CGRectMake(SDDeviceWidth-80 ,(inputH-30-10), 30, 30);
        self.failBtn.frame = CGRectMake(SDDeviceWidth-30-10,(inputH-30-10),30, 30);
        self.keyBoardContainer.frame =CGRectMake(0, inputH, SDDeviceWidth, keyBoardDefaultHeight);
        SDLog(@" self.inputViewContainer.frame:%@",NSStringFromCGRect(self.inputViewContainer.frame));
        SDLog(@" self.keyBoardContainer.frame:%@",NSStringFromCGRect(self.keyBoardContainer.frame));
        self.frame =CGRectMake(0,SDDeviceHeight-systemkeyBoardHeight-inputH, SDDeviceWidth,inputH+keyBoardDefaultHeight);
        
        if ([self.sd_delegate respondsToSelector:@selector(SDChatInputViewFrameWillChange:)]){
            [self.sd_delegate SDChatInputViewFrameWillChange:self];
        }
        
    }];
}


/**
 图片按钮点击

 @param failBtn 添加图片按钮
 */
-(void)failBtnClicked:(UIButton *)failBtn{
    
    failBtn.selected = !failBtn.selected;
    self.faceBtn.selected=NO;
    [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFace"] forState:UIControlStateNormal];
    [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFace_Highlight"] forState:UIControlStateHighlighted];
    systemkeyBoardHeight =CGRectGetHeight(self.keyBoardContainer.frame);
    if (failBtn.selected) //键盘
    {
        
        [self.chatText resignFirstResponder];
        [self.keyBoardContainer bringSubviewToFront:self.addFileView];
        [self customKeyboardMove:SDDeviceHeight-CGRectGetHeight(self.frame)];

        
    }else//添加文件
    {
        
        [self.chatText becomeFirstResponder];
        
    }
    

}

/**
 表情按钮点击

 @param faceBtn 表情按钮
 */
-(void)faceBtnClicked:(UIButton *)faceBtn{
    

            faceBtn.selected = !faceBtn.selected ;
            self.failBtn.selected=NO;
            systemkeyBoardHeight =CGRectGetHeight(self.keyBoardContainer.frame);
            if (!faceBtn.selected) //键盘
            {
                [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFace"] forState:UIControlStateNormal];
                [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFace_Highlight"] forState:UIControlStateHighlighted];
               
                [self.chatText becomeFirstResponder];
   
            }else//表情
            {
                [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddKeyboard"] forState:UIControlStateNormal];
                //        [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddFile_Highlight"] forState:UIControlStateHighlighted];
                [self.faceBtn setBackgroundImage:[UIImage imageNamed:@"chatAddkeyboard"] forState:UIControlStateHighlighted];
               
                [self.chatText resignFirstResponder];
             
                [self.keyBoardContainer bringSubviewToFront:self.addFaceView];
                [self customKeyboardMove:SDDeviceHeight-CGRectGetHeight(self.frame)];

                
            }
    
    if ([self.sd_delegate respondsToSelector:@selector(SDChatInputViewAddFaceClicked:)]){
        [self.sd_delegate SDChatInputViewAddFaceClicked:faceBtn];
    }
}


#pragma mark - 自定义键盘位移变化
- (void)customKeyboardMove:(CGFloat)customKbY
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, customKbY, SDDeviceWidth, CGRectGetHeight(self.frame));
        SDLog(@"self.frame:%@",NSStringFromCGRect(self.frame));
    }];
}

#pragma mark - textView代理
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
