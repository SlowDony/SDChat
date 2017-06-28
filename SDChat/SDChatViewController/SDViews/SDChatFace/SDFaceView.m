//
//  SDFaceView.m
//  miaohu
//
//  Created by Megatron Joker on 2017/6/1.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDFaceView.h"


#import "SDFaceArrTool.h"
#import "SDFaceModel.h" 
#import "SDFaceViewBtn.h"
@interface SDFaceView()

@property (nonatomic,strong) UIButton *deleteBtn;//删除按钮
@property (nonatomic,strong) NSMutableArray *faceViewBtnArr;//所有表情显示
@property (nonatomic,strong) SDFaceViewBtn *faceViewBtn;

@end

@implementation SDFaceView

-(NSMutableArray *)faceViewBtnArr{
    if(!_faceViewBtnArr){
        _faceViewBtnArr =[NSMutableArray array];
        
    }
    return _faceViewBtnArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        
        [deleteButton setImage:[UIImage imageNamed:@"chatFace_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"chatFace_delete_highlighted"] forState:UIControlStateHighlighted];
//        deleteButton.backgroundColor =[UIColor greenColor];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteBtn = deleteButton;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat leftInset =15;
    CGFloat topInset =15;
    
    
    //1.排列的所有表情
    NSInteger count =self.faceViewBtnArr.count;
    CGFloat faceViewW =(self.width-2*leftInset)/SDFaceMaxCols;
    CGFloat faceViewH =(self.height -topInset)/SDFaceMaxRows;
    for (int i =0; i<count ;i++){
        int row =i/SDFaceMaxCols; // 行数
        int loc =i%SDFaceMaxCols; //列数
        SDFaceViewBtn* faceViewBtn =self.faceViewBtnArr[i];
        faceViewBtn.x =leftInset+loc*faceViewW;
        faceViewBtn.y =topInset+row*faceViewH;
        faceViewBtn.width=faceViewW;
        faceViewBtn.height=faceViewH;
        
    }
    
    //2.布局删除按钮
    self.deleteBtn.width=faceViewW;
    self.deleteBtn.height=faceViewH;
    self.deleteBtn.x=SDDeviceWidth-leftInset-self.deleteBtn.width;
    self.deleteBtn.y=self.height-self.deleteBtn.height;

}
-(void)setFaceArr:(NSArray *)faceArr{
//    DLog(@"faceArr:%@---faceArr.count:%zd",faceArr,faceArr.count);
    _faceArr =faceArr;
    //添加新的表情
    //当前页显示的表情个数
    NSInteger count =faceArr.count;
    //当前页显示表情按钮的个数(含删除按钮)
    NSInteger currentFaceViewBtnCount =self.faceViewBtnArr.count;
    
    for (int i =0; i<count ;i++){
        SDFaceViewBtn *faceViewBtn =nil;
        if (i>=currentFaceViewBtnCount) { //faceViewBtn不够用需要创建
            faceViewBtn =[[SDFaceViewBtn alloc]init];
            [faceViewBtn addTarget:self action:@selector(faceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:faceViewBtn];
            [self.faceViewBtnArr addObject:faceViewBtn];
        }else {
            faceViewBtn =self.faceViewBtnArr[i];
        }
//        faceViewBtn.backgroundColor=SDRandomColor;
        faceViewBtn.faceModel=faceArr[i];
        faceViewBtn.hidden=NO;
        
    }
    for (int i=(int)count ;i<currentFaceViewBtnCount;i++){
        SDFaceViewBtn *faceViewBtn =self.faceViewBtnArr[i];
        faceViewBtn.hidden=YES;
    }
}
-(void)faceBtnClicked:(SDFaceViewBtn *)sender{
// DLog(@"点击表情按钮:%@",sender.faceModel.emoji);
    NSMutableDictionary *userInfo =[NSMutableDictionary dictionary];
    userInfo[SDSelectFaceKey] =sender.faceModel;
    [[NSNotificationCenter defaultCenter] postNotificationName:SDFaceDidSelectNotification object:nil userInfo:userInfo];
    
}











/**
 删除按钮
 */
-(void)deleteClick{
    SDLog(@"删除表情按钮");
    [[NSNotificationCenter defaultCenter] postNotificationName:SDFaceDidDeleteNotification object:nil];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
