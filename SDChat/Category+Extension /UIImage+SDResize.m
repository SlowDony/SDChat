//
//  UIImage+SDResize.m
//  SDChat
//
//  Created by slowdony on 2017/8/5.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import "UIImage+SDResize.h"

@implementation UIImage (SDResize)

+ (UIImage *)SDResizeWithImaName:(NSString *)iconName
{
    return [self SDResizeWithIma: [UIImage imageNamed: iconName]];
}

+ (UIImage *)SDResizeWithIma:(UIImage *)image
{
    //    CGFloat w = ima.size.width * 0.499;
    //    CGFloat h = ima.size.height * 0.499;
    CGFloat w =image.size.width*0.7;
    CGFloat h = image.size.height * 0.7;
    return [image resizableImageWithCapInsets: UIEdgeInsetsMake(h, w, h, w)];
}

+ (UIImage *)SDImageWithColor:(UIColor *)color
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
