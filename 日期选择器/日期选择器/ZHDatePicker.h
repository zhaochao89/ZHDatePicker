//
//  ZHDatePicker.h
//  日期选择器
//
//  Created by zhaochao on 17/1/4.
//  Copyright © 2017年 zhaochao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHDatePicker : UIView

@property (nonatomic, copy) void(^selectecBlock)(NSString *str);
@property (nonatomic, assign) int monthCount;   //显示几个月的时间

@end
