//
//  UIImage+YFResizing.m
//  YFWeChat
//
//  Created by dyf on 16/5/19.
//  Copyright © 2016年 dyf. All rights reserved.
//

#import "UIImage+YFResizing.h"

@implementation UIImage (YFResizing)

+ (UIImage *)yf_resizingWithImaName:(NSString *)iconName
{
    return [self yf_resizingWithIma: [UIImage imageNamed: iconName]];
}

+ (UIImage *)yf_resizingWithIma:(UIImage *)ima
{
//    CGFloat w = ima.size.width * 0.499;
//    CGFloat h = ima.size.height * 0.499;
    CGFloat w =ima.size.width*0.7;
    CGFloat h = ima.size.height * 0.7;
    return [ima resizableImageWithCapInsets: UIEdgeInsetsMake(h, w, h, w)];
}

+ (UIImage *)yf_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
