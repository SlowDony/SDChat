//
//  UIImage+SDResize.h
//  SDChat
//
//  Created by slowdony on 2017/8/5.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SDResize)
+ (UIImage *)SDResizeWithImaName:(NSString *)iconName;
+ (UIImage *)SDResizeWithIma:(UIImage *)image;
+ (UIImage *)SDImageWithColor:(UIColor *)color;

@end
