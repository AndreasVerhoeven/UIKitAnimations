Pod::Spec.new do |s|
    s.name             = 'UIKitAnimations'
    s.version          = '1.0.0'
    s.summary          = 'Provides helpers for easily animating setting text, labels and colors'
    s.homepage         = 'https://github.com/AndreasVerhoeven/UIKitAnimations'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Andreas Verhoeven' => 'cocoapods@aveapps.com' }
    s.source           = { :git => 'https://github.com/AndreasVerhoeven/UIKitAnimations.git', :tag => s.version.to_s }
    s.module_name      = 'UIKitAnimations'

    s.swift_versions = ['5.0']
    s.ios.deployment_target = '11.0'
    s.source_files = 'Sources/*.swift'
end
