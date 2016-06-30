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
let tap = UIRotationGestureRecognizer {
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

### UIControl

### UIGestureRecognizer

### UIBarButtonItem

---


## Contact

[Manuel García-Estañ Martínez](http://github.com/ManueGE)  
[@manueGE](https://twitter.com/ManueGE)

## License

MGEDateFormatter is available under the [MIT license](LICENSE.md).