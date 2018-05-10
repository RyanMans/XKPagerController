#
#  Be sure to run `pod spec lint XKPagerController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name             = 'XKPagerController'
  s.version          = '0.0.1'
  s.summary          = '分页滚动视图工具'

  s.homepage         = 'https://github.com/RyanMans/XKPagerController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ALLen、LAS' => '1696186412@qq.com' }
  s.source           = { :git => 'https://github.com/RyanMans/XKPagerController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'XKPagerController/Classes/**/*'

  s.dependency "Masonry"

end
