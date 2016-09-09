# YJLocationPicker
一行代码实现省市区三级地区选择功能
# CocoaPods支持
你可以在 Podfile 中加入下面一行代码来使用YJLocationPicker
    
    pod 'YJLocationPicker'
    
完成后需将demo中Resource资源文件Address.plist拖入您的工程中    
#示例代码
//选择地区按钮
- (IBAction)selectAction:(UIButton *)sender {

//直接调用

    [[[YJLocationPicker alloc] initWithSlectedLocation:^(NSArray *locationArray) {

    //array里面放的是省市区三级
    NSLog(@"%@", locationArray);
    //拼接后给button赋值
    [sender setTitle:[[locationArray[0] stringByAppendingString:locationArray[1]] stringByAppendingString:locationArray[2]]forState:UIControlStateNormal];

    }] show];

}
