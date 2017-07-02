//
//  SDFaceViewBtn.m
//  SDChat
//
//  Created by Megatron Joker on 2017/6/1.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDFaceViewBtn.h"
#import "SDFaceModel.h"

@interface SDFaceViewBtn ()

@end
@implementation SDFaceViewBtn

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
        self.adjustsImageWhenHighlighted=NO;
    }
    return self;
}

-(void)setFaceModel:(SDFaceModel *)faceModel{
    _faceModel =faceModel;
    if (faceModel.code){ //emjio表情
        //取消动画效果
        [UIView setAnimationsEnabled:NO];
        //设置emjio表情
        self.titleLabel.font =[UIFont systemFontOfSize:32];
        [self setTitle:faceModel.emoji forState:UIControlStateNormal];
    }
}



@end
