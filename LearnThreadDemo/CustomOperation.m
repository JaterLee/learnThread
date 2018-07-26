//
//  CustomOperation.m
//  LearnThreadDemo
//
//  Created by Jater on 2018/7/14.
//  Copyright © 2018年 李军灼. All rights reserved.
//

#import "CustomOperation.h"

@interface CustomOperation ()

@property (nonatomic, strong)  NSString *operName;

@property BOOL over;

@end

@implementation CustomOperation

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.operName = name;
    }
    return self;
}

- (void)main {
//    for (int i = 0; i < 3; i ++) {
//        NSLog(@"%@ %d", self.operName, i);
//        [NSThread sleepForTimeInterval:2];
//    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:1];
        if (self.cancelled) {
            return;
        }
        
        NSLog(@"%@",self.operName);
        self.over = YES;
    });
    
    while (!self.over && !self.cancelled) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

@end
