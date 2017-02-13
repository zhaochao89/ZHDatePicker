//
//  ViewController.m
//  日期选择器
//
//  Created by zhaochao on 17/1/4.
//  Copyright © 2017年 zhaochao. All rights reserved.
//

#import "ViewController.h"
#import "ZHDatePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZHDatePicker *datePicker = [[ZHDatePicker alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    datePicker.monthCount = 5;
    [datePicker setSelectecBlock:^(NSString *dataStr) {
        NSLog(@"确定选择：%@",dataStr);
    }];
    [self.view addSubview:datePicker];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
