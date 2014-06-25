Pod::Spec.new do |s|
  s.name     = 'DKCircleButton'
  s.version  = '1.1'
  s.license  = 'MIT'
  s.summary  = 'Sources of DKCircleButton and Demo app to show circle button tap effect.'
  s.homepage = 'https://github.com/kronik/DKCircleButton'
  s.author   = { 'Dmitry Klimkin' => 'dmitry@bubbly.net' }
  s.source   = { :git => 'https://github.com/kronik/DKCircleButton.git', :tag => '1.1' }
  s.platform = :ios, '7.0'
  s.source_files = 'DKCircleButton/DKCircleButton.{h,m}'
  s.frameworks = 'UIKit', 'CoreGraphics', 'Foundation'
  s.requires_arc = true
end