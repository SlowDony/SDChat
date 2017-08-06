//
//  UIColor+SDHex.h
//  SDChat
//
//  Created by slowdony on 2017/8/5.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SDHex)

/**
 从十六进制字符串获取颜色 (默认透明色)

 @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 @return color
 */
+(UIColor *)colorWithHexString:(NSString *)color;



/**
 从十六进制字符串获取颜色

 @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 @param alpha 透明色
 @return 转换后的color
 */
+(UIColor *)colorWithHexString:(NSString *)color
                         alpha:(CGFloat)alpha;
@end
