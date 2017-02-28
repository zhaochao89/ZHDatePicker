//
//  ZHDatePicker.m
//  日期选择器
//
//  Created by zhaochao on 17/1/4.
//  Copyright © 2017年 zhaochao. All rights reserved.
//

#import "ZHDatePicker.h"
#import "ZHCalender.h"

@interface ZHDatePicker() <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) NSInteger nowYear;    //当前年份
@property (nonatomic, assign) NSInteger nowMonth;   //当前月份
@property (nonatomic, assign) NSInteger nowDay;     //当前天

@end

@implementation ZHDatePicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [self prepareData];
        [self setupViews];
    }
    return self;
}

- (void)prepareData {
    NSDate *now = [NSDate date];
    //得到当前月份
    self.nowYear = [[ZHCalender sharedInstance] getYearWithDate:now];
    self.nowMonth = [[ZHCalender sharedInstance] getMonthWithDate:now];
    self.nowDay = [[ZHCalender sharedInstance] getDayWithDate:now];
    //组装日期数组
    NSMutableArray *mdArray = [NSMutableArray array];
    NSDateComponents *components = [[ZHCalender sharedInstance] getDateComponentsWithDate:now];
    for (int i = 0; i <= self.monthCount; i++) {
        components.month = i;
        NSDate *date = [[ZHCalender sharedInstance] getDateWithComponents:components toDate:now];
        NSLog(@"%@",date);
        NSUInteger month = [[ZHCalender sharedInstance] getMonthWithDate:date];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年MM月"];
        NSString *yearAndMonth = [formatter stringFromDate:date];
        
        NSUInteger allDays = [[ZHCalender sharedInstance] daysForMonthWithDate:date];
        for (NSUInteger i = 1; i <= allDays; i++) {
            if (self.nowMonth == month) {
                if (i <= self.nowDay) {
                    continue;
                } else {
                    [mdArray addObject:[NSString stringWithFormat:@"%@%02ld号",yearAndMonth,i]];
                }
            } else {
                [mdArray addObject:[NSString stringWithFormat:@"%@%02ld号",yearAndMonth,i]];
            }
        }
    }
    //组装时间
    NSMutableArray *hourArray = [NSMutableArray array];
    for (int i = 0; i < 24; i++) {
        NSString *hour = [NSString stringWithFormat:@"%02d点",i];
        [hourArray addObject:hour];
    }
    //分钟
    NSArray *minuteArrar = @[@"00分", @"30分"];
    self.dataSource = @[mdArray,hourArray,minuteArrar];
}

- (void)setupViews {
    UIButton *selectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 44 - 10, 0, 44, 30)];
    [selectedBtn setTitle:@"确定" forState:UIControlStateNormal];
    [selectedBtn setTitleColor:[UIColor colorWithRed:71 / 255.0 green:122 / 255.0 blue:249 / 255.0 alpha:1] forState:UIControlStateNormal];
    selectedBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:selectedBtn];
    [selectedBtn addTarget:self action:@selector(selectedBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.frame = CGRectMake(0, 30, self.frame.size.width, self.frame.size.height - 30);
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pickerView];
    [self.pickerView selectedRowInComponent:0];
}

- (void)setMonthCount:(int)monthCount {
    _monthCount = monthCount;
    [self prepareData];
    [self.pickerView reloadAllComponents];
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataSource.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataSource[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *str = self.dataSource[component][row];
    if (component == 0) {
        NSInteger year = [[str substringToIndex:4] integerValue];
        if (self.nowYear == year) {
            NSInteger month = [[str substringWithRange:NSMakeRange(5, 2)] integerValue];
            NSInteger day = [[str substringWithRange:NSMakeRange(8, 2)] integerValue];
            if ((self.nowMonth == month && self.nowDay + 1 == day) || (month = self.nowMonth + 1 && day == 1)) {
                return @"明天";
            }
            return [str substringFromIndex:5];
        }
        return [str substringFromIndex:2];
    }
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    NSLog(@"%ld  %ld",row,component);
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 180;
    }
    return 70;
}

- (void)selectedBtnPressed {
    
    NSInteger row1 = [self.pickerView selectedRowInComponent:0];
    NSInteger row2 = [self.pickerView selectedRowInComponent:1];
    NSInteger row3 = [self.pickerView selectedRowInComponent:2];
    NSString *str1 = self.dataSource[0][row1];
    NSString *str2 = self.dataSource[1][row2];
    NSString *str3 = self.dataSource[2][row3];
    
    NSString *year = [str1 substringToIndex:4];
    NSString *month = [str1 substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [str1 substringWithRange:NSMakeRange(8, 2)];
    NSString *date = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    
    NSString *hour = [str2 substringWithRange:NSMakeRange(0, 2)];
    NSString *minute = [str3 substringWithRange:NSMakeRange(0, 2)];
    NSString *hourMinute = [NSString stringWithFormat:@"%@:%@",hour,minute];
    
    NSString *strDate = [NSString stringWithFormat:@"%@ %@",date,hourMinute];
    NSLog(@"%@",strDate);
    
    if (self.selectecBlock) {
        self.selectecBlock(strDate);
    }
}

@end
