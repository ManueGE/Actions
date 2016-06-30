# Actions

**Actions** provides a set of extensions to add closures to UIView and UIControl. Also brings some convenience initializers to UIBarButtonItem and UIGestureRecognizer that allow creating them with a closure instead of a pair of target/action.

With Actions, you will easely add actions this way:

````
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

### UIView

You can make your `UIViews` to respond to simple touches in an easy way. The allowed gestures are members of the enum `Gestures` and their values are: 

- `tap`: One finger tap, accept one `Int` parameter that indicate the number of required touches. 
- `swipe`: One finger swipe, accept one `UISwipeGestureRecognizerDirection` parameter that indicate the direction of the swip. 
- `multiTap`: Any number of finger tap, accept two `Int` parameter that indicate the number of required fingers and touches. 
- `multiSwipe`: Any number of finger swipe, accept one `UISwipeGestureRecognizerDirection` parameter that indicate the direction of the swip and an `Int` parameter that indicate the number of required fingers and touches.

To add one of this gestures to a `UIView` you can do: 

````
let view = UIView()

// Not any gesture parameter means .tap(1):
view.addAction {
     print("view tapped")
}

// You can also make the closure have one parameter (the view):
view.addAction { view in
    print("view \(view) tapped")
}

// Add another gesture
view.addAction(.tap(3)) {
    print("View tapped 3 times")
}

// Add another gesture with view as closure parameter
view.addAction(.multiSwipe(direction: .Left, fingers: 2)) { view in
    print("View \(view) swipped left with 2 fingers")
}
```` 

All the add action methods returns the UIGestureRecognizer added to the view, in case you need it. 


### UIControl

Assign actions to your `UIControl` events. You can add



### UIGestureRecognizer

Create `UIGestureRecognizer` with a closure instead of a pair of target/action:

````
// without parameter
let recognizer = UIRotationGestureRecognizer {
    print("Gesture triggered")
}

// with parameter
let recognizer = UIRotationGestureRecognizer { recognizer in
    print("Gesture \(recognizer) triggered")
}
````


### UIBarButtonItem

Create `UIBarButtonItem` with a closure instead of a pair of target/action. You can create bar button items from its title, image or using a system type:

````
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

All this methods has come additional, optional parameters. They also can be used with closures that takes a parameter: 

````
let imageTitle = UIBarButtonItem(image: UIImage(named: "image")!) { item in
    print("image item \(item) pressed")
}
````
 

---


## Contact

[Manuel García-Estañ Martínez](http://github.com/ManueGE)  
[@manueGE](https://twitter.com/ManueGE)

## License

MGEDateFormatter is available under the [MIT license](LICENSE.md).