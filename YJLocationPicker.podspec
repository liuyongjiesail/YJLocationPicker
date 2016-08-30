Pod::Spec.new do |s|

  s.name         = "YJLocationPicker"
  s.version      = "0.0.2"
  s.summary      = "一行代码实现省市区三级地区选择功能"
  s.homepage     = "https://github.com/liuyongjiesail/YJLocationPicker"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "刘永杰" => "liuyongjiesail@icloud.com" }
  s.social_media_url   = "http://blog.csdn.net/yj_sail?viewmode=list"
  s.platform     = :ios, "5.0"
  s.ios.deployment_target = "5.0"
  s.source       = { :git => "https://github.com/liuyongjiesail/YJLocationPicker.git", :tag => "0.0.2" }

  s.source_files  = 'YJLocationPicker/*.{h,m}'
  s.requires_arc = true
  s.dependency "Masonry"

end
