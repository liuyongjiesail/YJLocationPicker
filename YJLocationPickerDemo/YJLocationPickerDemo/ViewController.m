//
//  ViewController.m
//  YJLocationPickerDemo
//
//  Created by 刘永杰 on 16/8/30.
//  Copyright © 2016年 刘永杰. All rights reserved.
//

#import "ViewController.h"
#import "YJLocationPicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)selectAction:(id)sender {
    
    //直接调用
    [[[YJLocationPicker alloc] initWithSlectedLocation:^(NSArray *locationArray) {
    
        //array里面放的是省市区三级
        NSLog(@"%@", locationArray);
        //拼接后给button赋值
        [sender setTitle:[locationArray componentsJoinedByString:@""] forState:UIControlStateNormal];
        
    }] show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
