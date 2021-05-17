# UIKitAnimations
Provide a few helpers for animating common UIKit operations, such as setting text


# What?

This library provides a few helper functions for easily animating common UIKit operations, such as setting text and images.

## UIView

- `view.performTransition()` does a cross fade of the view from one state to another
- `view.performTransitionIfNeeded()` same, but only if the `animated` parameter is true
- `UIView.performAnimationsIfNeeded()` only animates the changes if the `animated` parameter is true

- `view.shake()` shakes the view, usually to indicate an error
- `view.shakeWithHapticErrorFeedback()` same, but with haptic error feedback

Example:
```
view.performTransition {
	// update some complex view here, changes will crossfade
}

view.performTransitionIfNeeded(animated: true) {
	// update some complex view here, changes will crossfade
}

// indicates an error by shaking a textfield
inputTextField.shakeWithHapticErrorFeedback {
	inputTextField.becomeFirstResponder()
}

```


## UIImageView

- `setImage(_:animated:)` sets a new image with a crossfade transition, if animated is true
- `setImage(_:tintColor:animated)` same, but with a tint color parameter


Example:
```
imageView.setImage(UIImage(systemNamed: "gearshape"), tintColor: .red, animated: true)
```


## UILabel & UITextView

- `setText(_: animated:)` sets new text with a crossfade transition, if animated is true
- `setAttributedText(_:animated:)` same, but for attributed text
- `setText(_:textColor:animated:)` same, but text & color
- `setTextColor(_:animated:)` same, but only text color

Example:
```
label.setText("New text", animated: true)
textView.setAttributedText(newAttributedText, animated: true)
```

## UIWindow

- `switchRootViewController()` changes the root view controller, with a cross fade animation if wanted

Example:
```
window.setRootViewController(newViewController, animated: true)
```
