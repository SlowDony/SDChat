//
//  UIButton+buton_Text.m
//  
//
//  Created by tiancheng on 16/3/14.
//
//

#import "UIButton+buton_Text.h"
#import <objc/runtime.h>

@interface UIButton()
@property (nonatomic, assign) BOOL isIgnoreEvent;
@end
@implementation UIButton (buton_Text)

+ (void)load
{
}

+(void)addButton
{
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(mySendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}

+(void)removeButton
{
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(mySendAction:to:forEvent:));
    method_exchangeImplementations(b, a);
}

- (NSTimeInterval)timeInterval
{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
  
if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
    if (self.isIgnoreEvent) return;
    if (self.timeInterval > 0)
    {
        self.isIgnoreEvent = YES;
        [self performSelector:@selector(setIsIgnoreEvent:) withObject:0 afterDelay:self.timeInterval];
        
        SDLog(@"%f",self.timeInterval);
        
    }
    
    [self mySendAction:action to:target forEvent:event];

    }
}
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
