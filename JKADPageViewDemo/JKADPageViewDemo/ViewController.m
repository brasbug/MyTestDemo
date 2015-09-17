//
//  ViewController.m
//  JKADPageViewDemo
//
//  Created by Jack on 15/8/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "ViewController.h"
#import "JKADPageView.h"



@interface ViewController ()<JKADPageViewDelegate>

@property (nonatomic, strong) JKADPageView *adimageView;
@property (nonatomic, strong) NSArray *arrlist;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _adimageView = [[JKADPageView alloc]initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 200)];
    _adimageView.delegate = self;
    _adimageView.isWebImage = NO;
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    for (long i = 0; i < 4; i ++) {
        JKADImageItem *item = [[JKADImageItem alloc]init];
        item.imageURLStr = @"http://c.hiphotos.baidu.com/image/pic/item/f3d3572c11dfa9ec78e256df60d0f703908fc12e.jpg";
        item.image = [UIImage imageNamed:@"m1"];
        [mutArr addObject:item];
    }
    
    [_adimageView startAdsWithImageArray:mutArr.mutableCopy];
    
    [self.view addSubview:_adimageView];
    
    
    
    
    
}

- (void)clickItemAtIndext:(long)clickIndex imageModel:(JKADImageItem *)iamgeItme
{
    
}

- (void)setadsWebImage:(UIImageView *)imageView imageUrl:(NSString *)imageUrl
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
