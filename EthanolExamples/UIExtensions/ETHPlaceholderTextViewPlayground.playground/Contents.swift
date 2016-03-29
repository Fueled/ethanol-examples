import EthanolUIExtensions
import XCPlayground
/*:
# ETHPlaceholderTextView Playground
UITextView is a great control widely used and providing a lot of benefits.
However, one of its main limitations often force developers to subclass it/find workarounds: there is no placeholder.
Learn how to use ETHTextView in your project and enjoy a Text View with placeholder!
*/

/*:
## Regular String
*/
// Create the Placeholder Text View
let ethPlaceholderTextView = ETHPlaceholderTextView(frame: CGRectMake(0.0, 0.0, 250.0, 50.0))
ethPlaceholderTextView.backgroundColor = UIColor.lightGrayColor()

// Set regular placeholder
ethPlaceholderTextView.placeholder = "Type some text here."

// Get regular placeholder
print(ethPlaceholderTextView.placeholder)

// Change Placeholder insets
ethPlaceholderTextView.placeholderInsets = UIEdgeInsetsMake(ethPlaceholderTextView.placeholderInsets.top, 30.0, ethPlaceholderTextView.placeholderInsets.bottom, 30.0)

/*:
## Attributed String
*/
// Set attributed placeholder
let attributes = [
	NSUnderlineStyleAttributeName : 1,
	NSForegroundColorAttributeName : UIColor.redColor(),
	NSTextEffectAttributeName : NSTextEffectLetterpressStyle,
	NSStrokeWidthAttributeName : 3.0]

ethPlaceholderTextView.attributedPlaceholder = NSAttributedString(string: "Type some text here.", attributes: attributes)

/*:
## Behavior
*/
// As soon as some text will be typed in the text view directly or programmatically, the Placeholder will disappear
ethPlaceholderTextView.text = "I am some text"

// As soon as you will remove this text, the Placeholder will come back
ethPlaceholderTextView.text = ""
