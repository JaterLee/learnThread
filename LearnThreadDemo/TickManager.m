//
//  TickManager.m
//  LearnThreadDemo
//
//  Created by Jater on 2018/7/14.
//  Copyright © 2018年 李军灼. All rights reserved.
//

#import "TickManager.h"
#define TOTAL 50

@interface TickManager ()

@property int tickets; //剩余票数
@property int saleCount; //卖出票数

@property (nonatomic, strong)  NSThread *threadBJ;
@property (nonatomic, strong)  NSThread *threadSH;

@property (nonatomic, strong)  NSCondition *ticketCondition;

@end

@implementation TickManager

- (instancetype)init {
    if (self == [super init]) {
        self.tickets = TOTAL;
        self.threadBJ = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
        [self.threadBJ setName:@"BJ_thread"];
        self.threadSH = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
        [self.threadSH setName:@"SH_thread"];
        self.ticketCondition = [[NSCondition alloc] init];
    }
    return self;
}

- (void)sale {
    while (true) {
//        @synchronized (self) {
        [self.ticketCondition lock];
            //ticket>0 说明还要票可以卖
            if (self.tickets > 0) {
                [NSThread sleepForTimeInterval:0.5];
                self.tickets--;
                self.saleCount = TOTAL - self.tickets;
                NSLog(@"%@: 当前余票: %d, 售出: %d",[NSThread currentThread], self.tickets, self.saleCount);
            }
        [self.ticketCondition unlock];
//        }
    }
}

- (void)startToSale {
    [self.threadBJ start];
    [self.threadSH start];
}

@end
