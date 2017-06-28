//
//  SDHeader.h
//  SDChat
//
//  Created by slowdony on 2017/6/27.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#ifndef SDHeader_h
#define SDHeader_h

#define SDDeviceWidth [UIScreen mainScreen].bounds.size.width        //屏幕宽
#define SDDeviceHeight [UIScreen mainScreen].bounds.size.height      //屏幕高

//log扩展
#ifdef DEBUG
#   define SDLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define SDELog(err) {if(err) DLog(@"%@", err)}
#else
#   define SDLog(...)
#   define SDELog(err)
#endif

//color
#define mRGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define mHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define mHexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define fontHightColor mHexRGB(0x919191) //字体深色
#define fontNomalColor mHexRGB(0xbbbbbb) //字体浅色
#define fontBlackColor mHexRGB(0x404040) //字体黑

#define SDRandomColor mRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),1);

#define bjMainColor mHexRGB(0x27bac1) //主题色
#define bjColor mHexRGB(0xefefef)  //背景深灰色 mHexRGB(0xe4e4e4):浅灰0xf9f9f9
#define borderCol mHexRGB(0xe4e4e4)    //border颜色

#define buttonSeleteColor mHexRGB(0xe91a10) //字体深红色


/** 表情相关 */
// 表情的最大行数
#define SDFaceMaxRows 3
// 表情的最大列数
#define SDFaceMaxCols 7
// 每页最多显示多少个表情
#define SDFaceMaxCountPerPage (SDFaceMaxRows * SDFaceMaxCols - 1)

#endif /* SDHeader_h */
