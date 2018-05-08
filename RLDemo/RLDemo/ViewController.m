//
//  ViewController.m
//  RLDemo
//
//  Created by MK on 2018/5/7.
//  Copyright © 2018年 MK. All rights reserved.
//

#import "ViewController.h"
#import <LEEAlert/LEEAlert.h>
#import "Progress.h"
#import "mkview.h"
@interface ViewController ()
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, strong)NSTimer *timer1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 添加主线程runloop监听者
    [self addMainObserver];
    
    // 添加子线程runloop监听者
//    [self addOtherObserver];
    
    // 此处使用sleep是为了避免使用timer造成runloop的timer事件的干扰。
    sleep(3);
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat randomAlpha = (arc4random() % 100)*0.01;
        [self.view setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:randomAlpha]];
//        [LEEAlert alert].config.LeeTitle(@"zhu").LeeContent(@"ci").LeeShow();
//        [Progress progress].config.Title(@"qweqwe").Content(@"zxczczxc").show();
    });
}
// 添加子线程runloop监听者
- (void)addOtherObserver
{
    [NSThread detachNewThreadWithBlock:^{
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer)
                  {
                      NSLog(@"###cmm子线程###timer时间到");
                  }];
        
        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            switch (activity) {
                case kCFRunLoopEntry:
                    NSLog(@"###cmm子线程###进入kCFRunLoopEntry");
                    break;
                    
                case kCFRunLoopBeforeTimers:
                    NSLog(@"###cmm子线程###即将处理Timer事件");
                    break;
                    
                case kCFRunLoopBeforeSources:
                    NSLog(@"###cmm子线程###即将处理Source事件");
                    break;
                    
                case kCFRunLoopBeforeWaiting:
                    NSLog(@"###cmm子线程###即将休眠");
                    break;
                    
                case kCFRunLoopAfterWaiting:
                    NSLog(@"###cmm子线程###被唤醒");
                    break;
                    
                case kCFRunLoopExit:
                    NSLog(@"###cmm子线程###退出RunLoop");
                    break;
                    
                default:
                    break;
            }
        });
        
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
//        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, NO);//会退出runloop
        [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];//不会退出runloop
        CFRunLoopRun();
    }];
}

// 添加主线程runloop监听者
- (void)addMainObserver
{
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        NSLog(@"currentMode---------->%@",[NSRunLoop currentRunLoop].currentMode);
        switch (activity) {
                
            case kCFRunLoopEntry:
                NSLog(@"###cmm###进入kCFRunLoopEntry");
                break;
                
            case kCFRunLoopBeforeTimers:
                NSLog(@"###cmm###即将处理Timer事件");
                break;
                
            case kCFRunLoopBeforeSources:
                NSLog(@"###cmm###即将处理Source事件");
                break;
                
            case kCFRunLoopBeforeWaiting:
                NSLog(@"###cmm###即将休眠");
                break;
                
            case kCFRunLoopAfterWaiting:
                NSLog(@"###cmm###被唤醒");
                break;
                
            case kCFRunLoopExit:
                NSLog(@"###cmm###退出RunLoop");
                break;
                
            default:
                break;
        }
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSLog(@"###cmm###timer时间到");
    }];
}

@end
