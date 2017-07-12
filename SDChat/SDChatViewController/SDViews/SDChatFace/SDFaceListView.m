//
//  SDFaceListView.m
//  SDChat
//
//  Created by Megatron Joker on 2017/6/1.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDFaceListView.h"
#import "SDFaceView.h"

@interface SDFaceListView ()<UIScrollViewDelegate>
/**
 列表给你的送
 */
@property (nonatomic,strong)  UIScrollView *faceScrollView;

/**
 分页小点
 */
@property (nonatomic,strong) UIPageControl *facePageControl;
@end


@implementation SDFaceListView

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
        //1.添加滚动式图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        
        scrollView.delegate = self;
        
        scrollView.backgroundColor = [UIColor clearColor];
        //隐藏滚动条,屏蔽多余的子控件
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = YES;
        [self addSubview:scrollView];
         self.faceScrollView =scrollView;
        
        //2.添加分页
        UIPageControl *pageControl =[[UIPageControl alloc]init];
        [pageControl setPageIndicatorTintColor:[UIColor orangeColor]];
        [pageControl setCurrentPageIndicatorTintColor:[UIColor grayColor]];
        [self addSubview:pageControl];
        self.facePageControl =pageControl;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //1. facePageControl.frame
    self.facePageControl.width=SDDeviceWidth;
    self.facePageControl.height=35;
    self.facePageControl.y =self.height-self.facePageControl.height;
    
    
    //2. faceScrollView.frame
    self.faceScrollView.width=SDDeviceWidth;
    self.faceScrollView.height=self.facePageControl.y;
    
    // 3.设置UIScrollView内部控件的尺寸
    NSInteger count = self.facePageControl.numberOfPages;
    CGFloat faceW = self.faceScrollView.width;
    CGFloat faceH = self.faceScrollView.height;
    self.faceScrollView.contentSize = CGSizeMake(count * faceW, 0);
    for (int i = 0; i<count; i++) {
        SDFaceView *faceView = self.faceScrollView.subviews[i];
        faceView.width = faceW;
        faceView.height = faceH;
        faceView.x = i * faceW;
    }
}

-(void)setFaceArr:(NSMutableArray *)faceArr{
    _faceArr =faceArr;
    //设置总页数
    NSInteger totalPages =(faceArr.count + SDFaceMaxCountPerPage -1)/SDFaceMaxCountPerPage;
    
    NSInteger currentFaceViewCount =self.faceScrollView.subviews.count;
    self.facePageControl.numberOfPages=totalPages;
    self.facePageControl.currentPage=0;
    self.facePageControl.hidden=totalPages<=1;
    
    for (int i=0; i<totalPages; i++) {
        SDFaceView *faceView =nil;
        if(i >=currentFaceViewCount) //循环创建(重复利用SDFaceView)
        {
            faceView=[[SDFaceView alloc]init];
//            faceView.backgroundColor =SDRandomColor;
            [self.faceScrollView addSubview:faceView];
        }else {
            faceView=self.faceScrollView.subviews[i];
        }
        
        //设置faceView表情数据
        NSInteger loc =i*SDFaceMaxCountPerPage;
        NSInteger len =SDFaceMaxCountPerPage;
        if (i*len>faceArr.count)//判断最后一页是否显示满表情,如果不全显示会出现数组越界
            
        {
            len =faceArr.count-loc;
        }
        
        NSRange faceRange =NSMakeRange(loc, len);
        //每次只截取所有表情数据的一页表情传给faceView
        NSArray *faceArrs =[faceArr subarrayWithRange:faceRange];
        faceView.faceArr =faceArrs;
        faceView.hidden=NO;
    }
    
    //由于循环使用faceView,所有隐藏后面不需要的faceView;
    for (int i =(int)totalPages; i<currentFaceViewCount; i++) {
        SDFaceView *faceView =self.faceScrollView.subviews[i];
        faceView.hidden=YES;
        
    }
    //重新布局子控件
    [self setNeedsLayout];
    
    //表情滚动到最前面
    self.faceScrollView.contentOffset=CGPointZero;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.facePageControl.currentPage=(int)(scrollView.contentOffset.x/scrollView.width+0.5);
}











@end
