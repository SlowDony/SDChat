//
//  UIImage+YFResizing.h
//  YFWeChat
//
//  Created by dyf on 16/5/19.
//  Copyright © 2016年 dyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YFResizing)

+ (UIImage *)yf_resizingWithImaName:(NSString *)iconName;
+ (UIImage *)yf_resizingWithIma:(UIImage *)ima;

+ (UIImage *)yf_imageWithColor:(UIColor *)color;

@end
