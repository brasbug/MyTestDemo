/*
 *  ViewController.m
 *  XCMultiTableDemo
 *
 * Created by Kingiol on 2013-07-19.
 * Copyright (c) 2013 Kingiol Ding. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */
#import "ViewController.h"

#import "XCMultiSortTableView.h"

@interface ViewController () <XCMultiTableViewDataSource>

@end

@implementation ViewController {
    NSMutableArray *headData;
    NSMutableArray *leftTableData;
    NSMutableArray *rightTableData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initData];
    
    XCMultiTableView *tableView = [[XCMultiTableView alloc] initWithFrame:CGRectInset(self.view.bounds, 5.0f, 5.0f)];
    tableView.leftHeaderEnable = YES;
    tableView.datasource = self;
    [self.view addSubview:tableView];
    
}

- (void)initData {
    headData = [NSMutableArray arrayWithCapacity:10];
    [headData addObject:@"姓名"];
    [headData addObject:@"年龄"];
    [headData addObject:@"性别"];
    [headData addObject:@"身份"];
    [headData addObject:@"电话"];
    [headData addObject:@"电话"];
    [headData addObject:@"电话"];
    [headData addObject:@"电话"];
    [headData addObject:@"电话"];
    [headData addObject:@"电话"];
    [headData addObject:@"电话"];
    [headData addObject:@"电话"];
    [headData addObject:@"电话"];
    [headData addObject:@"电话"];
    [headData addObject:@"姓名"];
    [headData addObject:@"年龄"];
    [headData addObject:@"性别"];
    [headData addObject:@"身份"];
    [headData addObject:@"电话"];
    [headData addObject:@"电话"];
    leftTableData = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *one = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 1000; i++) {
        [one addObject:[NSString stringWithFormat:@"%i", i]];
    }
    [leftTableData addObject:one];

    
    
    rightTableData = [NSMutableArray arrayWithCapacity:10];
    
    NSMutableArray *oneR = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 1000; i++) {
        NSMutableArray *ary = [NSMutableArray arrayWithCapacity:10];
        for (int j = 0; j < headData.count; j++) {
            if (j == 1) {
                [ary addObject:[NSNumber numberWithInt:random() % 5]];
            }else if (j == 2) {
                [ary addObject:[NSNumber numberWithInt:random() % 10]];
            }
            else {
                [ary addObject:[NSString stringWithFormat:@"column %d %d", i, j]];
            }
        }
        [oneR addObject:ary];
    }
    [rightTableData addObject:oneR];
 
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - XCMultiTableViewDataSource


- (NSArray *)arrayDataForTopHeaderInTableView:(XCMultiTableView *)tableView {
    return [headData copy];
}
- (NSArray *)arrayDataForLeftHeaderInTableView:(XCMultiTableView *)tableView InSection:(NSUInteger)section {
    return [leftTableData objectAtIndex:section];
}

- (NSArray *)arrayDataForContentInTableView:(XCMultiTableView *)tableView InSection:(NSUInteger)section {
    return [rightTableData objectAtIndex:section];
}


- (NSUInteger)numberOfSectionsInTableView:(XCMultiTableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(XCMultiTableView *)tableView contentTableCellWidth:(NSUInteger)column {
    if (column == 0) {
        return 100;
    }
    if (column == 5) {
        return 100;
    }
    return 60;
}

- (CGFloat)tableView:(XCMultiTableView *)tableView cellHeightInRow:(NSUInteger)row InSection:(NSUInteger)section {
    if (section == 0) {
        return 60.0f;
    }else {
        return 30.0f;
    }
}

- (UIColor *)tableView:(XCMultiTableView *)tableView bgColorInSection:(NSUInteger)section InRow:(NSUInteger)row InColumn:(NSUInteger)column {
    if (row == 1 && section == 0) {
        return [UIColor whiteColor];
    }
    return [UIColor clearColor];
}

- (UIColor *)tableView:(XCMultiTableView *)tableView headerBgColorInColumn:(NSUInteger)column {
    if (column == -1) {
        return [UIColor whiteColor];
    }else if (column == 1) {
        return [UIColor whiteColor];
    }
    return [UIColor clearColor];
}

@end
