//
//  NSObject+SDLogModel.m
//  SDChat
//
//  Created by slowdony on 2017/8/5.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import "NSObject+SDLogModel.h"
#import <objc/runtime.h>
@implementation NSObject (SDLogModel)

//重写description
/*
- (NSString *)description
{
    //初始化字典
    NSMutableDictionary *dictionary =[[NSMutableDictionary alloc]init];
    //得到当前class的所有属性
    uint count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    //循环并用kvc得到每个属性的值
    
    for (int i =0; i<count;i++){
        objc_property_t property = properties[i];
        NSString *name =@(property_getName(property));
        id value =[self valueForKey:name]?:@"nil"; //默认值为nil
        [dictionary setObject:value forKey:name];
        
    }
    //释放
    free(properties);
    
    
    return [NSString stringWithFormat:@"<%@:== %p>--%@",[self class],self,dictionary];
}

 */
@end
