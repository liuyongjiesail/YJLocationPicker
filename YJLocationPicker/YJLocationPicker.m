//
//  YJLocationPicker.m
//  PickerDemo
//
//  Created by 刘永杰 on 16/8/22.
//  Copyright © 2016年 sail. All rights reserved.
//

#import "YJLocationPicker.h"
#import "YJToolBar.h"

static CGFloat const PickerViewHeight = 240;
//static CGFloat const PickerViewLabelWeight = 32;

@interface YJLocationPicker () <UIPickerViewDataSource, UIPickerViewDelegate>

//data
@property (strong, nonatomic) NSDictionary *pickerDic;
/** 当前省数组 */
@property (strong, nonatomic) NSArray *provinceArray;
/** 当前城市数组 */
@property (strong, nonatomic) NSArray *cityArray;
/** 当前地区数组 */
@property (strong, nonatomic) NSArray *townArray;
/** 当前选中数组 */
@property (strong, nonatomic) NSArray *selectedArray;

/** 选择器 */
@property (nonatomic, strong, nullable)UIPickerView *pickerView;
/** 工具器 */
@property (nonatomic, strong, nullable)YJToolBar *toolBar;
/** 边线 */
@property (nonatomic, strong, nullable)UIView *lineView;

@end

@implementation YJLocationPicker


- (instancetype)initWithSlectedLocation:(SelectedLocation)selectedLocation
{
    self = [self init];
    self.selectedLocation = selectedLocation;
    return self;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        [self loadData];
    }
    return self;
}


- (void)setupUI
{
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
    [self.layer setOpaque:0.0];
    [self addSubview:self.pickerView];
    [self.pickerView addSubview:self.lineView];
    [self addSubview:self.toolbar];
    [self addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
    
    [self reloadata];

}

//自定义pcierview显示
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    NSString *text;
    if (component == 0) {
        text =  self.provinceArray[row];
    }else if (component == 1){
        text =  self.cityArray[row];
    }else{
        if (self.townArray.count > 0) {
            text = self.townArray[row];
        }else{
            text =  @"";
        }
    }
    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;
}


- (void)cancelAction
{
    [self remove];
}

- (void)confirmAction
{
    
    NSString *province = [self.provinceArray objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    NSString *city = [self.cityArray objectAtIndex:[self.pickerView selectedRowInComponent:1]];
    NSString *town;
    if (self.townArray.count != 0) {
        
        town = [self.townArray objectAtIndex:[self.pickerView selectedRowInComponent:2]];
        
    } else {
        
        town = @"";
    }
    self.selectedLocation(@[province, city, town]);
    [self remove];
}

//选择的数组
- (void)reloadata;
{
    NSString *province = [self.provinceArray objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    NSString *city = [self.cityArray objectAtIndex:[self.pickerView selectedRowInComponent:1]];
    NSString *town;
    if (self.townArray.count != 0) {
        
        town = [self.townArray objectAtIndex:[self.pickerView selectedRowInComponent:2]];
        
    } else {
        
        town = @"";
    }
    self.toolBar.title = [[province stringByAppendingString:[NSString stringWithFormat:@" %@", city]] stringByAppendingString:[NSString stringWithFormat:@" %@", town]];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y -= PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y -= PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:1];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
    }];
}

- (void)remove
{
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y += PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y += PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:0];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        CGFloat pickerW = [UIScreen mainScreen].bounds.size.width;
        CGFloat pickerH = PickerViewHeight - 44;
        CGFloat pickerX = 0;
        CGFloat pickerY = [UIScreen mainScreen].bounds.size.height + 44;
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
        [_pickerView setDataSource:self];
        [_pickerView setDelegate:self];
    }
    return _pickerView;
}

- (YJToolBar *)toolbar
{
    if (!_toolBar) {
        _toolBar = [[YJToolBar alloc]initWithTitle:@"选择城市地区"
                                 cancelButtonTitle:@"取消"
                                     confirmButtonTitle:@"确定"
                                         addTarget:self
                                      cancelAction:@selector(cancelAction)
                                          confirmAction:@selector(confirmAction)];
        _toolBar.x = 0;
        _toolBar.y = [UIScreen mainScreen].bounds.size.height;
    }
    return _toolBar;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        [_lineView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    }
    return _lineView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
