Pod::Spec.new do |s|
  s.name     = 'DKCircleButton'
  s.version  = '1.0'
  s.license  = 'MIT'
  s.summary  = 'Sources of DKCircleButton and Demo app to show circle button tap effect.'
  s.homepage = 'https://github.com/kronik/DKCircleButton'
  s.author   = { 'Dmitry Klimkin' => 'dmitry@bubbly.net' }
  s.source   = { :git => 'https://github.com/kronik/DKCircleButton.git', :commit => '91bf0d9e0bbdf088e1bf0d5fd5ba8f02d47872fe' }
  s.platform = :ios, '7.0'
  s.source_files = 'DKCircleButton/DKCircleButton.{h,m}'
  s.frameworks = 'UIKit', 'CoreGraphics', 'Foundation'
  s.requires_arc = true
end