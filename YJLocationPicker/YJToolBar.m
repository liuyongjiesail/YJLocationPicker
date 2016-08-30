//
//  YJToolBar.m
//  PickerDemo
//
//  Created by 刘永杰 on 16/8/22.
//  Copyright © 2016年 sail. All rights reserved.
//

#import "YJToolBar.h"
#import "Masonry/Masonry.h"


@interface YJToolBar ()

@property (nonatomic, strong, nullable)UIButton *cancleButton;
@property (nonatomic, strong, nullable)UILabel *titleLabel;
@property (nonatomic, strong, nullable)UIButton *confirmButton;

@end

@implementation YJToolBar

- (instancetype)initWithTitle:(nullable NSString *)title
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                confirmButtonTitle:(nullable NSString *)confirmButtonTitle
                    addTarget:(nullable id)target
                 cancelAction:(SEL)cancelAction
                     confirmAction:(SEL)confirmAction{
    
    self = [self init];
    
    [self.titleLabel setText:title];
    
    [self.cancleButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [self.cancleButton addTarget:target action:cancelAction forControlEvents:UIControlEventTouchUpInside];
    
    [self.confirmButton setTitle:confirmButtonTitle forState:UIControlStateNormal];
    [self.confirmButton addTarget:target action:confirmAction forControlEvents:UIControlEventTouchUpInside];
    
    return self;
    
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    _title = nil;
    _font = [UIFont systemFontOfSize:15];
    _titleColor = [UIColor blackColor];
    
    self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    [self setBackgroundColor:[UIColor whiteColor]];
    
    //创建
    self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.titleLabel = [[UILabel alloc] init];
    
    //添加
    [self addSubview:self.titleLabel];
    [self addSubview:self.cancleButton];
    [self addSubview:self.confirmButton];
    
    //配置
    [self.cancleButton setTitleColor:self.titleColor forState:UIControlStateNormal];
    [self.cancleButton.titleLabel setFont:self.font];
    
    [self.confirmButton setTitleColor:self.titleColor forState:UIControlStateNormal];
    [self.confirmButton.titleLabel setFont:self.font];
    
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setTextColor:self.titleColor];
    [self.titleLabel setFont:self.font];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //autoLayout
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leftMargin.mas_equalTo(0);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(33);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.rightMargin.equalTo(self.mas_right).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.cancleButton.mas_height);
        make.width.equalTo(self.cancleButton.mas_width);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leftMargin.equalTo(self.cancleButton.mas_right).offset(10);
        make.rightMargin.equalTo(self.confirmButton.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.cancleButton.mas_height);
    }];
    
}

#pragma mark - --- setters 属性 ---

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titleLabel setText:title];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self.cancleButton.titleLabel setFont:font];
    [self.confirmButton.titleLabel setFont:font];
    [self.titleLabel setFont:font];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self.titleLabel setTextColor:titleColor];
    [self.cancleButton setTitleColor:titleColor forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:titleColor forState:UIControlStateNormal];
    
}



@end
