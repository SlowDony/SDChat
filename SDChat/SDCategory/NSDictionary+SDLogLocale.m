//
//  NSDictionary+SDLogLocale.m
//  SDChat
//
//  Created by slowdony on 2017/8/5.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import "NSDictionary+SDLogLocale.h"

@implementation NSDictionary (SDLogLocale)

-(NSString *) descriptionWithLocale:(id)locale{
    NSMutableString *mulStr =[NSMutableString string ];
    
    [mulStr appendString:@"{\n"];
    for (id obj in self) {
        [mulStr appendFormat:@"\t%@ =%@;\n",obj,[self objectForKey:obj]];
    }
    [mulStr appendString:@"}"];
    return mulStr;
}

@end
