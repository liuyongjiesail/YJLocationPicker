//
//  YJLocationPicker.h
//  PickerDemo
//
//  Created by 刘永杰 on 16/8/22.
//  Copyright © 2016年 sail. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SelectedLocation)(NSArray *locationArray);

@interface YJLocationPicker : UIButton

@property (copy, nonatomic)SelectedLocation selectedLocation;

//初始化回传
- (instancetype)initWithSlectedLocation:(SelectedLocation)selectedLocation;
//显示
- (void)show;

@end
