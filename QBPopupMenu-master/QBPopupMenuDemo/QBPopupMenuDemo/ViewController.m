//
//  ViewController.m
//  QBPopupMenuDemo
//
//  Created by Tanaka Katsuma on 2013/11/22.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "ViewController.h"

#import "QBPopupMenu.h"
#import "QBPlasticPopupMenu.h"

@interface ViewController ()

@property (nonatomic, strong) QBPopupMenu *popupMenu;
@property (nonatomic, strong) QBPlasticPopupMenu *plasticPopupMenu;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (nonatomic, strong) UIButton *button;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollview.contentSize  = CGSizeMake([UIScreen mainScreen].bounds.size.width *2, self.scrollview.frame.size.height);
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button setTitle:@"test" forState:UIControlStateNormal];
    _button.frame = CGRectMake(500, 100, 60, 44);
    [_scrollview addSubview:_button];
    
    
    QBPopupMenuItem *item = [QBPopupMenuItem itemWithTitle:@"Hello" target:self action:@selector(action)];
    QBPopupMenuItem *item2 = [QBPopupMenuItem itemWithTitle:@"Cut" target:self action:@selector(action)];
    QBPopupMenuItem *item3 = [QBPopupMenuItem itemWithTitle:@"Copy" target:self action:@selector(action)];
    QBPopupMenuItem *item4 = [QBPopupMenuItem itemWithTitle:@"Delete" target:self action:@selector(action)];
    QBPopupMenuItem *item5 = [QBPopupMenuItem itemWithImage:[UIImage imageNamed:@"clip"] target:self action:@selector(action)];
    QBPopupMenuItem *item6 = [QBPopupMenuItem itemWithTitle:@"Delete" image:[UIImage imageNamed:@"trash"] target:self action:@selector(action)];
    NSArray *items = @[item, item2, item3, item4, item5, item6];
    
    QBPopupMenu *popupMenu = [[QBPopupMenu alloc] initWithItems:items];
    popupMenu.highlightedColor = [[UIColor colorWithRed:0 green:0.478 blue:1.0 alpha:1.0] colorWithAlphaComponent:0.8];
    self.popupMenu = popupMenu;
    popupMenu.color = [UIColor redColor];
    
    QBPlasticPopupMenu *plasticPopupMenu = [[QBPlasticPopupMenu alloc] initWithItems:items];
    plasticPopupMenu.height = 40;
    self.plasticPopupMenu = plasticPopupMenu;
}


- (IBAction)showPopupMenu:(id)sender
{
//    UIButton *button = (UIButton *)sender;
    [self.popupMenu showInScrollView:self.scrollview targetRect:_button.frame animated:YES];
}

- (IBAction)showPlasticPopupMenu:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [self.plasticPopupMenu showInView:self.view targetRect:button.frame animated:YES];
}

- (void)action
{
    NSLog(@"*** action");
}

@end
