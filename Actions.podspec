Pod::Spec.new do |spec|

  spec.name         = "Actions"
  spec.version      = "1.0.0"
  spec.summary      = "An easy way to add swift closures to UIView, UIControl and more"
  spec.description  = <<-DESC
  Actions provides a set of extensions to add closures to UIView and UIControl. 
  Also brings some convenience initializers to UIBarButtonItem and UIGestureRecognizer that allow creating them with a closure instead of a pair of target/action
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

end
