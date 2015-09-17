//
//  ImageViewController.m
//  MultiThreadTest
//
//  Created by Jack on 15/8/21.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIScrollViewDelegate>


@property (nonatomic, weak) IBOutlet UIScrollView *scrollview;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;



@end

@implementation ImageViewController

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


- (void)setScrollview:(UIScrollView *)scrollview
{
    _scrollview = scrollview;
    _scrollview.minimumZoomScale = 0.1;
    _scrollview.maximumZoomScale = 2.0;
    _scrollview.delegate = self;
    self.scrollview.contentSize = self.image ? self.image.size:CGSizeZero;
    
    
}


- (UIImageView *)imageView
{
    if (_imageView) {
        return _imageView;
    }
    _imageView = [[UIImageView alloc]init];
    return _imageView;
}

- (UIImage *)image
{
    return self.imageView.image;
}

-(void)setImageURL:(NSURL *)imageURL
{
    
    
    _imageURL = imageURL;
//    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
    [self startDownLoadingImage];
}

- (void)startDownLoadingImage
{
    self.image = nil;
    if (self.imageURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration  = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *sesson = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [sesson downloadTaskWithRequest:request completionHandler:^(NSURL *localFile, NSURLResponse *response, NSError *error) {
            if (!error) {
                if ([request.URL isEqual:self.imageURL]) {
                    UIImage *loImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:localFile]];
//                    self.image = loImage;
                    dispatch_async(dispatch_get_main_queue(), ^{self.image = loImage;});
//                    [self performSelectorOnMainThread:@selector(setImage:) withObject:loImage waitUntilDone:NO];
                    
                }
            }
        }];
        [task resume];
        
        
        
    }
}


- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.scrollview.contentSize = self.image ? self.image.size:CGSizeZero;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scrollview addSubview:self.imageView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
