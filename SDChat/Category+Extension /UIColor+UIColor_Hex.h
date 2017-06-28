//
//  UIColor+UIColor_Hex.h
//  16进制颜色
//
//  Created by tcrj on 15/12/21.
//  Copyright (c) 2015年 tcrj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColor_Hex)
+(UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
