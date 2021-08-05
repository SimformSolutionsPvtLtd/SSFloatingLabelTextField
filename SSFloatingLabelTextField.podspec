#
#  Be sure to run `pod spec lint SSFloatingLabelTextField.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "SSFloatingLabelTextField"
  spec.version      = "0.0.2"
  spec.summary      = "A small framework to use Floating label and show errors of SSFloatingLabelTextField."
  spec.description  =    "A small framework to use Floating label and show errors of SSFloatingLabelTextField."
            
  spec.homepage     = "https://github.com/mobile-simformsolutions/SSFloatingLabelTextField"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { 'Simform Solutions' => 'developer@simform.com' }
  spec.platform     = :ios
  spec.ios.deployment_target = "11.0"
  spec.swift_versions   = '5.0'

  spec.source       = { :git => "https://github.com/mobile-simformsolutions/SSFloatingLabelTextField", :tag => "#{spec.version}" }

  spec.source_files  = "SSFloatingLabelTextField/Classes/**"
  spec.framework  = 'UIKit'

end
