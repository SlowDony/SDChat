//
//  UIBarButtonItem+SDExtension.h
//  SDChat
//
//  Created by slowdony on 2017/8/5.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SDExtension)
/**
 *  创建一个带图片的item
 *
 *  @param target      点击item后调用的哪个对象方法
 *  @param action      点击item后调用target的那个方法
 *  @param image       图片
 *  @param selectImage 高亮
 *
 *  @return 创建完的item
 */
+(UIBarButtonItem *)itemTarget:(id)target
                    withAction:(SEL)action
                      andImage:(NSString *)image
                andSelectImage:(NSString *)selectImage;

/**
 *  创建带文字的item
 *
 *  @param target 点击item后调用的哪个对象的方法
 *  @param action 点击item后调用target的哪个方法
 *  @param title  文字
 *
 *  @return 创建完的item
 */
+(UIBarButtonItem *)itemWithaddTarget:(id)target
                               action:(SEL)action
                             andTitle:(NSString *)title;
@end
