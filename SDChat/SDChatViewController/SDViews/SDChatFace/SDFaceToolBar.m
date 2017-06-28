//
//  SDFaceToolBar.m
//  miaohu
//
//  Created by Megatron Joker on 2017/6/1.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDFaceToolBar.h"

@interface SDFaceToolBar ()

/**
 发送按钮
 */
@property (nonatomic,strong)  UIButton *sendBtn;

@end
@implementation SDFaceToolBar

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
        //1.添加发送按钮
        //
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        sendBtn.backgroundColor=[UIColor blueColor];
        [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sendBtn.titleLabel.font =[UIFont systemFontOfSize:15];
        [sendBtn  addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: sendBtn];
        self.sendBtn =sendBtn;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.sendBtn.width=50;
    self.sendBtn.height=self.height;
    self.sendBtn.x=SDDeviceWidth-50;
    
}
-(void)senderBtn:(UIButton *)sender{
    SDLog(@"发送");
    [[NSNotificationCenter defaultCenter] postNotificationName:SDFaceDidSendNotification object:nil];
    
}























@end
