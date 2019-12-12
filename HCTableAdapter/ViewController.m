//
//  ViewController.m
//  HCTableAdapter
//
//  Created by 贺超 on 2019/12/10.
//  Copyright © 2019年 贺超. All rights reserved.
//

#import "ViewController.h"
#import "HCDemoTableViewAdapter.h"
#import "HCTestSectionVM.h"
#import "HCDemoTableViewEventHandler.h"
#import "HCTableViewEventDelegate.h"
#import "HCDemoTableViewEvent.h"

@interface ViewController () <HCTableViewEventDelegate>

@property (nonatomic, strong) UITableView *testTableView;
@property (nonatomic, strong) HCDemoTableViewAdapter *tableAdapter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
    [self bindData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.testTableView.frame = self.view.bounds;
}

#pragma mark - Action

- (void)showTestAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Test" message:@"测试事件通过响应链传递到vc去处理" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - HCTableViewEventDelegate

- (void)onCatchEvent:(id<HCTableViewEventDataProtocol>)event {
    switch (event.eventType) {
        case HCDemoTableViewEventTypeClickCell: {
            [self showTestAlert];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Private Method

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.testTableView];
}

- (void)bindData {
    HCTableViewDataSource *dataSource = [[HCTableViewDataSource alloc] init];
    [dataSource.dataSource addObject:[[HCTestSectionVM alloc] initWithDict:@{}]];
    [dataSource.dataSource addObject:[[HCTestSectionVM alloc] initWithDict:@{}]];
    HCDemoTableViewEventHandler *eventHandler = [[HCDemoTableViewEventHandler alloc] init];
    self.tableAdapter = [[HCDemoTableViewAdapter alloc] initWithTableDataSource:dataSource tableView:self.testTableView eventHandler:eventHandler];
}

#pragma mark - Getter && Setter

- (UITableView *)testTableView {
    if (_testTableView == nil) {
        _testTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _testTableView.backgroundColor = [UIColor lightGrayColor];
        if (@available(iOS 11.0, *)) {
            _testTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        _testTableView.contentInset = UIEdgeInsetsMake([UIApplication sharedApplication].statusBarFrame.size.height + 44, 0, 0, 0);
    }
    
    return _testTableView;
}

@end
