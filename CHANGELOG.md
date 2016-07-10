# Change Log
### 1.3.0 (10 July 2016)
- `addObserver(to:object:action:)` has been deprecated in favor of `observe(name:object:action:)`.
- `NSNotificationCenter` observations can be stopped by calling `stopObserving(action)`. 
- New `NSNotificationCenter` method (`add(observer:name:object:action:`) to add actions binded to the lifetime of a given object. 

### 1.2.0 (6 July 2016)
- Add support to `NSNotificationCenter`.

### 1.1.0 (4 July 2016)
- Add support to `NSTimer`.

### 1.0.0 (1 July 2016)
- Initial version with support to `UIView`, `UIControl`, `UIGestureRecognizer` and `UIBarButtonItem`.