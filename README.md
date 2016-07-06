# Actions

**Actions** provides a set of extensions to add closures to `UIView` and `UIControl` instances. Also brings some methods to `UIBarButtonItem`, `UIGestureRecognizer`, `NSTimer` and `NSNotificationCenter`, that allow using them with a closure instead of a pair of target/action.

With **Actions**, you will easily add actions this way:

````swift
// UIView
let imageView = UIImageView()
imageView.addAction(.swipe(.Left)) {
    print("Image swipped")
}

// UIControl
let button = UIButton()
button.addAction(.TouchUpInside) {
    print("Button tapped")
}

// UIGestureRecognizer
let gestureRecognizer = UIRotationGestureRecognizer {
    print("Gesture triggered")
}

// UIBarButtonItem
let barButtonItem = UIBarButtonItem(title: "Title") {
    print("Bar button item tapped")
}

// NSTimer
NSTimer.scheduledTimerWithTimeInterval(5) {
    print("timer fired")
}

// NSNotificationCenter
NSNotificationCenter.defaultCenter().addObserver(to: "NotificationName") {
    print("Notification received")
}
````

Keep reading to know how!

## Installation

Add the following to your `Podfile`:

````
pod 'Actions'
````

Then run `$ pod install`.

And finally, in the classes where you need **Actions**: 

````
import Actions
````

If you don’t have CocoaPods installed or integrated into your project, you can learn how to do so [here](http://cocoapods.org).

## Usage

## Supported classes
- [UIView](#UIView)
- [UIControl](#UIControl)
- [UIGestureRecognizer](#UIGestureRecognizer)
- [UIBarButtonItem](#UIBarButtonItem)
- [NSTimer](#NSTimer)
- [NSNotificationCenter](#NSNotificationCenter)

<a name="UIView"></a>
### UIView [☝️](#usage)

You can make your `UIViews` to respond to simple touches. The allowed gestures are members of the enum `Gestures` and their values are: 

- `tap`: One finger tap, accept one `Int` parameter that indicate the number of required touches. 
- `swipe`: One finger swipe, accept one `UISwipeGestureRecognizerDirection` parameter that indicate the direction of the swip. 
- `multiTap`: Tap with any number of fingers, accept two `Int` parameter that indicate the number of required fingers and touches. 
- `multiSwipe`: Swipe with any number of fingers; accept one `UISwipeGestureRecognizerDirection` parameter that indicate the direction of the swip and an `Int` parameter that indicate the number of required fingers and touches.

To add one of this gestures to a `UIView` you can do: 

````swift
let view = UIView()

// Not any gesture argument means .tap(1):
view.addAction {
     print("view tapped")
}

// You can also make the closure have one argument (the own view):
view.addAction { (view: UIView) in
    print("view \(view) tapped")
}

// Add 3 tap gesture
view.addAction(.tap(3)) {
    print("View tapped 3 times")
}

// Add a multi swipe gesture with the view as closure argument
view.addAction(.multiSwipe(direction: .Left, fingers: 2)) { (view: UIView) in
    print("View \(view) swipped left with 2 fingers")
}
```` 

All the add action methods returns the UIGestureRecognizer added to the view, in case you need it. 

<a name="UIControl"></a>
### UIControl [☝️](#usage)

Assign actions to your `UIControl` events. 

You can add three types of closures:

- Without any argument
- With one argument, it will be the control itself.
- With two arguments, the first one will be the control itself, the second one will be the `UIEvent?`.

You can add actions:

- To a single `UIControlEvent`, using the method `addAction(_:UIControlEvent, action:Void -> Void)`
- To multple control events at the same time: `addAction(_:[UIControlEvent], action:Void -> Void)`

Here there are some examples:

````swift
// Closure without arguments and single event
button.addAction(.TouchUpInside) {
    print("button tapped")
}

// Closure with one argument and multiple events
textField.addAction([.EditingChanged, .EditingDidEnd]) { (textField: UITextField) in
    print("Text did change: \(textField.text)")
}

// Closure with two arguments
button.addAction(.TouchUpInside) { (sender, event) in
    print("Sender: \(sender), Event: \(event)")
}
````

<a name="UIGestureRecognizer"></a>
### UIGestureRecognizer [☝️](#usage)

Create `UIGestureRecognizer` with a closure instead of a pair of target/action:

````swift
// without argument
let recognizer = UIRotationGestureRecognizer {
    print("Gesture triggered")
}

// with argument
let recognizer = UIRotationGestureRecognizer { (recognizer: UIRotationGestureRecognizer) in
    print("Gesture \(recognizer) triggered")
}
````

<a name="UIBarButtonItem"></a>
### UIBarButtonItem [☝️](#usage)

Create `UIBarButtonItem` with a closure instead of a pair of target/action. You can create bar button items from its title, image or using a system type:

````swift
let imageTitle = UIBarButtonItem(image: UIImage(named: "image")!) {
    print("image item pressed")
}

let titleItem = UIBarButtonItem(title: "Title") {
    print("title item pressed")
}

let systemItem = UIBarButtonItem(barButtonSystemItem: .Action) {
    print("system item pressed")
}
````

All these methods has some additional, optional arguments. They also can be used with closures that takes the `UIBarButtonItem` as an argument, for instance: 

````swift
let imageTitle = UIBarButtonItem(image: UIImage(named: "image")!) { (item: UIBarButtonItem) in
    print("image item \(item) pressed")
}
````

<a name="NSTimer"></a>
### NSTimer [☝️](#usage)

Create a `NSTimer` with a closure instead of a pair of target/action. You can create timers in three different ways:

````swift
// Scheduele a timer
NSTimer.scheduledTimerWithTimeInterval(5) {
    print("timer fired")
}

// create a timer with a fire date
let timer = NSTimer(fireDate: date, interval: 0.5, repeats: true) {
    print("timer fired")
}

// create a timer with a time interval
let timer = NSTimer(timeInterval: 0.5) {
    print("timer fired")
}
````

All these methods has some additional, optional arguments as `repeats` and `userInfo`. They also can be used with closures that takes the `NSTimer` as an argument, for example:

````swift
let timer = NSTimer(fireDate: date, interval: 0.5, repeats: true) { (timer: NSTimer) in
    print("timer fired \(timer)")
}
````

<a name="NSNotificationCenter"></a>
### NSNotificationCenter [☝️](#usage)

Add an observer to a `NSNotificationCenter` with a closure instead of a pair of observer/selector:

````swift
let center = NSNotificationCenter.defaultCenter()

// Void closure
center.addObserver(to: notificationName) {
    print("Notification received")
}

// Notification as closure parameter
center.addObserver(to: notificationName, object: self) { (notification: NSNotification) in
    print("Notification \(notification) received")
}
````

These two methods has one additional, optional arguments `object`: the object whose notifications the observer wants to receive.


---


## Contact

[Manuel García-Estañ Martínez](http://github.com/ManueGE)  
[@manueGE](https://twitter.com/ManueGE)

## License

Actions is available under the [MIT license](LICENSE.md).
