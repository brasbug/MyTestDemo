
#import "ViewController.h"
#import "RLPieChart.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RLPieChart * chart = [[RLPieChart alloc] pieChartWithRadius:100 center:self.view.center colors:@[[UIColor redColor],[UIColor greenColor],[UIColor lightGrayColor],[UIColor blackColor]] ratioes:@[@0.3,@0.4,@0.2,@0.1] offSet:10];
    chart.tappedHandler = ^(NSInteger index, BOOL status) {
        NSLog(@"第%ld个被点击了，状态是%@",(long)index,[NSNumber numberWithBool:status]);
    };
    [self.view addSubview:chart];
}

@end
