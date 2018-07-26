//
//  ViewController.m
//  LearnThreadDemo
//
//  Created by 李军灼 on 2018/7/14.
//  Copyright © 2018年 李军灼. All rights reserved.
//

#import "ViewController.h"
#import <pthread/pthread.h>

#import "TickManager.h"
#import "TestSingle.h"
#import "CustomOperation.h"

@interface ViewController ()

@property (nonatomic, strong)  NSOperationQueue *operQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    TickManager *manager = [TickManager new];
//    [manager startToSale];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 30);
    [btn setTitle:@"pThread" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickPThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 150, 100, 30);
    [btn setTitle:@"NSThread" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickNSThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 200, 100, 30);
    [btn setTitle:@"GCD" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickGCD) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 250, 100, 30);
    [btn setTitle:@"单例" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSingle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 300, 100, 30);
    [btn setTitle:@"Time" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickTime) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 350, 100, 30);
    [btn setTitle:@"NSOperation" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(operationTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - pThread Test

- (void)clickPThread {
    pthread_t pthread;
    pthread_create(&pthread, NULL, run, NULL);
    NSLog(@"我在主线程中执行");
}

void *run(void *data) {
    NSLog(@"我在子线程中执行");
    for (int i = 1; i < 10; i++) {
        NSLog(@"%d",i);
        sleep(1);
    }
    return NULL;
}

#pragma mark - NSThread Test

- (void)clickNSThread {
    NSLog(@"主线程执行-NSThread!!!");
    
    //1.通过alloc init的方式创建并执行线程
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(runThread1) object:nil];
    [thread1 setName:@"Name_Thread1"];
    [thread1 setThreadPriority:0.7];
    [thread1 start];
    
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(runThread1) object:nil];
    [thread2 setName:@"Name_Thread2"];
    [thread2 setThreadPriority:0.5];
    [thread2 start];
    
    
    //2.通过detachNewThreadSelecor 方式创建并执行线程
//    [NSThread detachNewThreadSelector:@selector(runThread1) toTarget:self withObject:nil];
    
    //3.通过performSelectorInBackground 方式创建线程
//    [self performSelectorInBackground:@selector(runThread1) withObject:nil];
}

- (void)runThread1 {
    NSLog(@"%@ 子线程执行-NSThread!!!", [NSThread currentThread]);
    for (int i = 0; i <= 10; i++) {
        NSLog(@"%d", i);
        sleep(1);
        if (i == 10) {
            [self performSelectorOnMainThread:@selector(runMainThread) withObject:nil waitUntilDone:YES];
        }
    }
}

- (void)runMainThread {
    NSLog(@"回到主线程执行");
}

#pragma mark - GCD Test

- (void)clickGCD {
    NSLog(@"执行GCD");
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        //执行耗时任务
//        NSLog(@"start  task 1");
//        [NSThread sleepForTimeInterval:3];
//        dispatch_async(dispatch_get_main_queue(), ^{
//        //回到主线程刷新UI
//            NSLog(@"主线程刷新UI");
//        });
//    });
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        NSLog(@"start Task 1");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 1");
//    });
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"start Task 2");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 2");
//    });
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"start Task 3");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 3");
//    });
    
//    dispatch_queue_t queue = dispatch_queue_create("com.test.gcd.queue", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//        NSLog(@"start Task 1");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 1");
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"start Task 2");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 2");
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"start Task 3");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 3");
//    });
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.gcd_group", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [self sendRequest1:^{
        NSLog(@"request1 done");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self sendRequest2:^{
        NSLog(@"request1 done");
        dispatch_group_leave(group);
    }];
    
    
//    dispatch_group_async(group, queue, ^{
//        [self sendRequest1:^{
//            NSLog(@"request1 done");
//        }];
//    });
//    
//    dispatch_group_async(group, queue, ^{
//        [self sendRequest2:^{
//            NSLog(@"request2 done");
//        }];
//    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"所有任务都完成了");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程刷新UI");
        });
    });
}

- (void)sendRequest1:(void(^)())block {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"start Task 1");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task 1");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
    });
}

- (void)sendRequest2:(void(^)())block {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"start Task 2");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task 2");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
    });
}


#pragma mark - Single

- (void)clickSingle {
//    TestSingle *single = [TestSingle instance];
//    NSLog(@"single = %@",single);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"excute only one");
    });
}

#pragma mark - Time Test

- (void)clickTime {
    NSLog(@"-----beign----");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"jelay excute");
    });
}

#pragma mark - NSOperation Test

- (void)operationTest {
    NSLog(@"main thread");
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSInvocationOperation *invocationOper = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationAction) object:nil];
//        [invocationOper start];
//        NSLog(@"end");
//    });
    
//    NSBlockOperation *blockOper = [NSBlockOperation blockOperationWithBlock:^{
//        for (int i = 0; i < 3; i ++) {
//            NSLog(@"invovation %d",i);
//            [NSThread sleepForTimeInterval:1];
//        }
//    }];
    
    if (!self.operQueue) {
        self.operQueue = [[NSOperationQueue alloc] init];
    }
    [self.operQueue setMaxConcurrentOperationCount:4];
    
//    [blockOper start];
    
//    [self.operQueue addOperation:blockOper];
//    NSLog(@"end");
    
    CustomOperation *customOperA = [[CustomOperation alloc] initWithName:@"OperA"];
    CustomOperation *customOperB = [[CustomOperation alloc] initWithName:@"OperB"];
    CustomOperation *customOperC = [[CustomOperation alloc] initWithName:@"OperC"];
    CustomOperation *customOperD = [[CustomOperation alloc] initWithName:@"OperD"];
    
    [customOperD addDependency:customOperA];
    [customOperA addDependency:customOperC];
    [customOperC addDependency:customOperB];

    [self.operQueue addOperation:customOperA];
    [self.operQueue addOperation:customOperB];
    [self.operQueue addOperation:customOperC];
    [self.operQueue addOperation:customOperD];

    NSLog(@"end");
}

- (void)invocationAction {
    for (int i = 0; i < 3; i ++) {
        NSLog(@"invovation %d",i);
        [NSThread sleepForTimeInterval:1];
    }
}

@end
