//
//  SDChatAddFileKeyBoardView.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/19.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatAddFileKeyBoardView.h"
@interface SDChatAddFileKeyBoardView()

/**
 添加的btn
 */
@property (nonatomic,strong) NSMutableArray *btnArrs;

/**
 添加按钮标题lab
 */
@property (nonatomic,strong)NSMutableArray *titleLabArrs;

/**
 按钮标题
 */
@property (nonatomic,strong) NSArray *btnTitleArrs;
@end


@implementation SDChatAddFileKeyBoardView


-(NSMutableArray *)btnArrs{
    if(!_btnArrs){
        _btnArrs =[NSMutableArray array];
    }
    return  _btnArrs;
}
-(NSMutableArray *)titleLabArrs{
    if (!_titleLabArrs) {
        _titleLabArrs =[NSMutableArray array];
        
    }
    return _titleLabArrs;
}
-(NSArray *)btnTitleArrs{
    if (!_btnTitleArrs) {
        _btnTitleArrs =@[
                         @{@"btnTitle":sdPhotoBtnTitle,@"btnBjImage":@"chatAddImage"},
                         @{@"btnTitle":sdCameraBtnTitle,@"btnBjImage":@"chatAddCamera"},
                        ];
    }
    return _btnTitleArrs;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=bjColor;
        
        for (NSDictionary*dic in self.btnTitleArrs) {
            [self setBtnWithDic:dic];
        }
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnW = 50;
    CGFloat btnH = btnW;
    CGFloat orx = 20;
    CGFloat ory = 20;
    
    NSInteger maxRowCount = 2;
    NSInteger maxColCount = 4;
    CGFloat colMargin = (CGRectGetWidth(self.bounds) - 2 * orx - maxColCount * btnW) / (maxColCount + 1);
    CGFloat rowMargin = (CGRectGetHeight(self.bounds) - 2 * ory - maxRowCount * btnH) / (maxColCount + 1);
    
    NSInteger index = 0;
    for (UIButton *btn in self.btnArrs) {
        
        if (index < (maxColCount * maxRowCount)) {
            //
            NSInteger col = index % maxColCount;
            NSInteger row = index / maxColCount;
            btn.frame = CGRectMake(orx + col * (btnW + colMargin), (ory + row * (btnH + rowMargin)), btnW, btnH);
            
        }
        
        index ++;
    }
    CGFloat titleLabW =50;
    CGFloat titleLabH =20;
    NSInteger labIndex =0;
    for (UILabel *titleLab in self.titleLabArrs) {
        CGFloat titleLabX;
        CGFloat titleLabY;
        if (labIndex < (maxColCount * maxRowCount)) {
            //
            NSInteger col = labIndex % maxColCount;
            NSInteger row = labIndex / maxColCount;
            titleLabX =orx + col * (btnW + colMargin);
            titleLabY =(ory + row * (btnH + rowMargin)+btnH);
            titleLab.frame = CGRectMake(titleLabX, titleLabY, titleLabW, titleLabH);
        }
        labIndex ++;
    }
    
   
    
    
    
   
    
    
}
- (void)setBtnWithDic:(NSDictionary *)btnDic
{
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor whiteColor];
    
//  [btn setBackgroundImage:[UIImage imageNamed:btnDic[@"btnBjImage"]] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:btnDic[@"btnBjImage"]] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(moreInputBtnClick:) forControlEvents: UIControlEventTouchUpInside];
    btn.layer.cornerRadius=10;
    btn.layer.masksToBounds=YES;
    [self addSubview:btn];
    
    //
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor =fontBlackColor;
    label.text =btnDic[@"btnTitle"];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    [self addSubview:label];
    
    [self.titleLabArrs addObject:label];
    [self.btnArrs addObject:btn];
}
-(void)moreInputBtnClick:(UIButton *)sender
{
    SDLog(@"更多");
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
