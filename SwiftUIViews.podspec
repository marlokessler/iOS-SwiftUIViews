Pod::Spec.new do |spec|

  spec.name         = "SwiftUIViews"
  spec.version      = "1.0.0"
  spec.summary      = "A set of useful views and view helper for SwiftUI."
  spec.homepage     = "https://github.com/Connapptivity/iOS-SwiftUIViews"

  spec.license      = { :type => "Restricted", :file => "LICENSE" }

  spec.author       = { "Marlo Kessler" => "marlo.kessler@connapptivity.de" }

  spec.ios.deployment_target     = "13.0"

  spec.source = { :git => "https://github.com/Connapptivity/iOS-SwiftUIViews.git", :tag => "#{spec.version}" }
  
  spec.source_files  = "Sources", "Sources/**/*.{swift}"
  spec.exclude_files = "Sources/Exclude"
  
  spec.framework  = "Foundation"
  
end
