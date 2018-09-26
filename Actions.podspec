Pod::Spec.new do |spec|

  spec.name         = "Actions"
  spec.version      = "3.0.1"
  spec.summary      = "An easy way to add swift closures to UIView, UIControl and more"
  spec.description  = <<-DESC
Actions provides a set of extensions to add closures to `UIView` and `UIControl` instances. Also brings some methods to `UIBarButtonItem`, `UIGestureRecognizer`, `Timer` and `NotificationCenter`, that allow using them with a closure instead of a pair of target/action.
                   DESC
  spec.homepage     = "https://github.com/ManueGE/Actions/"
  spec.license      = "MIT"


  spec.author    = "Manuel García-Estañ"
  spec.social_media_url   = "http://twitter.com/ManueGE"

  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/ManueGE/Actions.git", :tag => "#{spec.version}" }

  spec.requires_arc = true
  spec.framework = "Foundation"

  spec.source_files = "actions/actions/*.{swift}"
  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }

end
