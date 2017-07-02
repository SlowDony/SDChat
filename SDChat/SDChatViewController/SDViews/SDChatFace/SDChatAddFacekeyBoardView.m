//
//  SDChatAddFacekeyBoardView.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/31.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatAddFacekeyBoardView.h"
//表情view
#import "SDFaceListView.h"
//表情工具栏.(含发送按钮)
#import "SDFaceToolBar.h"
//表情数据源
#import "SDFaceArrTool.h"
@interface SDChatAddFacekeyBoardView ()


/**
 表情列表
 */
@property (nonatomic,strong)SDFaceListView *faceListView;

/**
 表情工具栏(发送按钮)
 */
@property (nonatomic,strong)SDFaceToolBar *faceToolBar;

@end
@implementation SDChatAddFacekeyBoardView

+(instancetype)faceKeyBoard{
    return [[self alloc]init];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.backgroundColor=bjColor;
        //1.添加listView;
        SDFaceListView *faceListView =[[SDFaceListView alloc]init];
        [self addSubview:faceListView];
        faceListView.faceArr= [[NSMutableArray alloc]initWithArray:[SDFaceArrTool emojiFaces]];

        faceListView.backgroundColor=[UIColor clearColor];
        
        self.faceListView=faceListView;
        //2.添加工具栏
        SDFaceToolBar *faceToolBar =[[SDFaceToolBar alloc]init];
        [self addSubview:faceToolBar];
        faceToolBar.backgroundColor=[UIColor whiteColor];
        self.faceToolBar =faceToolBar;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //1.设置faceToolBarFrame
    self.faceToolBar.width =self.width;
    self.faceToolBar.height=35;
    self.faceToolBar.y =self.height-self.faceToolBar.height;
    //2.设置listViewframe
    self.faceListView.width=self.width;
    self.faceListView.height=self.faceToolBar.y;
}
@end
