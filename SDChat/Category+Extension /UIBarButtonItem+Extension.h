//
//  UIBarButtonItem+Extension.h
//  DemoPods
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 Dony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemTarget:(id)target WithAction:(SEL)action andImage:(NSString *)image andSelectImage:(NSString *)selectImage;
+(UIBarButtonItem *)itemWithaddTarget:(id)target Action:(SEL)action andTitle:(NSString *)title;
@end
