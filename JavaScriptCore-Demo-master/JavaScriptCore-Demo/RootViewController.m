//
//  RootViewController.m
//  SocketIO-Demo
//
//  Created by Jakey on 14/12/25.
//  Copyright (c) 2014 com.test All rights reserved.
//

#import "RootViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface RootViewController ()
@property (strong, nonatomic) JSContext *context;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}


- (IBAction)testBtnPressed:(id)sender {
    
}




- (IBAction)JSCallOC:(id)sender {
    JSCallOCViewController *jsCallOC = [[JSCallOCViewController alloc]init];
    [self.navigationController pushViewController:jsCallOC animated:YES];
}

- (IBAction)OCCallJS:(id)sender {
    OCCallJSViewController *ocCallJS = [[OCCallJSViewController alloc]init];
    [self.navigationController pushViewController:ocCallJS animated:YES];
}

- (IBAction)HighchartsWeb:(id)sender {
    HighchartsWebViewController *highchartsWeb =[[HighchartsWebViewController alloc]init];
    [self.navigationController pushViewController:highchartsWeb animated:YES];
}
@end
