import EthanolUIExtensions
import XCPlayground
/*:
# ETHPlaceholderTextView Playground
UITextView is a great control widely used and providing a lot of benefits. 
However, one of its main limitations often force developers to subclass it/find workarounds: there is no placeholder.
Learn how to use ETHTextView in your project and enjoy a Text View with placeholder!
*/

// Create the Placeholder Text View
var ethPlaceholderTextView = ETHPlaceholderTextView()

// Set regular placeholder
ethPlaceholderTextView.placeholder = "Type some text here."

// Get regular placeholder
ETHPlaceholderTextView.placeholder
