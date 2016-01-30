//
//  XiaoMing+Ext.m
//  RuntimeDemo
//
//  Created by liuxj on 16/1/29.
//  Copyright © 2016年 LXJ. All rights reserved.
//

#import "LXJObject+Category.h"
#import <objc/runtime.h>

@implementation LXJObject (Category)

char cPara;

- (void)setOtherProperty:(NSString *)otherProperty
{
    objc_setAssociatedObject(self, &cPara, otherProperty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)otherProperty
{
    return objc_getAssociatedObject(self, &cPara);
}

@end
