#
# Be sure to run `pod lib lint SGVAttributedNavigationBarTitle.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SGVAttributedNavigationBarTitle"
  s.version          = "1.0.0"
  s.summary          = "Attributed strings in navigation bars."
  s.description      = <<-DESC
                       Enables use of attributed strings as navigation item titles by [ab]using the power of Objective-C runtime.
                       DESC
  s.homepage         = "https://github.com/sanekgusev/SGVAttributedNavigationBarTitle"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Alexander Gusev" => "sanekgusev@gmail.com" }
  s.source           = { :git => "https://github.com/sanekgusev/SGVAttributedNavigationBarTitle.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sanekgusev'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'

  s.public_header_files = 'Pod/Classes/UINavigationBar+SGVAttributedNavigationBarTitle.h', 'Pod/Classes/UINavigationItem+SGVAttributedNavigationBarTitle.h'
  s.frameworks = 'UIKit'

  s.xcconfig = { 
  'ENABLE_STRICT_OBJC_MSGSEND' => 'YES',

  'GCC_TREAT_WARNINGS_AS_ERRORS' => 'YES',
  'CLANG_WARN_DOCUMENTATION_COMMENTS' => 'YES',
  'GCC_WARN_FOUR_CHARACTER_CONSTANTS' => 'YES',
  'GCC_WARN_SHADOW' => 'YES',
  'GCC_WARN_64_TO_32_BIT_CONVERSION' => 'YES',
  'CLANG_WARN_IMPLICIT_SIGN_CONVERSION' => 'YES',
  'GCC_WARN_INITIALIZER_NOT_FULLY_BRACKETED' => 'YES',
  'GCC_WARN_ABOUT_MISSING_FIELD_INITIALIZERS' => 'YES',
  'GCC_WARN_ABOUT_MISSING_PROTOTYPES' => 'YES',
  'GCC_WARN_ABOUT_MISSING_NEWLINE' => 'YES',
  'CLANG_WARN_ASSIGN_ENUM' => 'YES',
  'GCC_WARN_SIGN_COMPARE' => 'YES',
  'CLANG_WARN_SUSPICIOUS_IMPLICIT_CONVERSION' => 'YES',
  'GCC_WARN_UNKNOWN_PRAGMAS' => 'YES',
  'CLANG_WARN_UNREACHABLE_CODE' => 'YES',
  'GCC_WARN_UNUSED_LABEL' => 'YES',

  'CLANG_WARN__DUPLICATE_METHOD_MATCH' => 'YES',
  'CLANG_WARN_OBJC_IMPLICIT_ATOMIC_PROPERTIES' => 'YES',
  'GCC_WARN_MULTIPLE_DEFINITION_TYPES_FOR_SELECTOR' => 'YES',
  'CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS' => 'YES',
  'GCC_WARN_STRICT_SELECTOR_MATCH' => 'YES',

  'CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF' => 'YES',
  'CLANG_WARN_OBJC_REPEATED_USE_OF_WEAK' => 'YES',

  }
end
