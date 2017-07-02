//
//  SDFaceArrTool.m
//  SDChat
//
//  Created by Megatron Joker on 2017/6/1.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDFaceArrTool.h"

#import "SDFaceModel.h"


@implementation SDFaceArrTool
/* emoji表情*/
static NSArray *_emojiFaces;
+ (NSArray *)emojiFaces
{
    if (!_emojiFaces) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"sdChatFaceEmoji.plist" ofType:nil];
        _emojiFaces = [SDFaceModel mj_objectArrayWithFile:plist];
        [_emojiFaces makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    
    return _emojiFaces;
}

@end
