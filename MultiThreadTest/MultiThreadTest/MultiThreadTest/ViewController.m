//
//  ViewController.m
//  MultiThreadTest
//
//  Created by Jack on 15/8/21.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"[FileName:%s]\n" "[FuctionName:%s]\n" "[Line:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

#import "ViewController.h"
#import "ImageViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    dispatch_queue_t otherQ = dispatch_queue_create("ada", NULL);
    
//    UIViewAnimationOptions
    
    DLog(@"Test")
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *vc = (ImageViewController *)segue.destinationViewController;
        vc.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://b.zol-img.com.cn/desk/bizhi/image/4/1920x1200/1384480949246.jpg"]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
