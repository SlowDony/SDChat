//
//  NSSArray+NSLogLocale.m
//  补充-数组的扩展中文输出
//
//  Created by apple on 15-4-14.
//  Copyright (c) 2015年 CrazyDony. All rights reserved.
//

#import "NSArray+NSLogLocale.h"

@implementation NSArray (NSLogLocale)
- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *resString =[NSMutableString string];
    [resString appendString:@"(\n"];
    //遍历数组中的每个中文字符串,用mutableString进行拼接,最后输出的是一个字符串,所以可以显示中文,达到了数组中文输出的目的
    for (id obj in self) {
                //if中的是最后一项输出时不加逗号
        if ([obj isEqual:[self lastObject]]) {
            [resString appendFormat:@"\t%@\n",obj];
        }
        else
        {
            [resString appendFormat:@"\t%@,\n",obj];
        }
    }
    [resString appendString:@")"];
    return resString;
}
@end
