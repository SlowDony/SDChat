//
//  NSDictionary+ChinesePrint.m
//  Foundation框架之NSDationary
//
//  Created by apple on 15-4-17.
//  Copyright (c) 2015年 CrazyDony. All rights reserved.
//

#import "NSDictionary+ChinesePrint.h"

@implementation NSDictionary (ChinesePrint)
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
