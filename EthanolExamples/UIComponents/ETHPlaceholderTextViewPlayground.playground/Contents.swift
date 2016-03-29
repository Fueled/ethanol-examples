
import EthanolUIComponents
/*:
Finally a Text View that supports a placeholder text!
-----
__Tip:__ EthanolUIComponents supports IBDesignable and IBInspectable for its properties.
*/

let ethPlaceholderTextView = ETHPlaceholderTextView(frame: CGRectMake(0.0, 0.0, 150.0, 50.0))

/*:
## Regular placeholder text
Specify some text to your placeholder. Text color will be default iOS placeholder color.
*/
ethPlaceholderTextView.placeholder = "I am a placeholder"

/*:
## What if we type in some text?
*/
ethPlaceholderTextView.text = "I am the actual text"

/*:
## Attributed Text Placeholder
Specify custom attributed text as placeholder.
*/
let placeholderText = "I am a custom placeholder"
let attributedString = NSMutableAttributedString(string: placeholderText)
attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range: NSMakeRange(0, placeholderText.characters.count))
attributedString.addAttribute(NSFontAttributeName, value: (ethPlaceholderTextView.font?.fontWithSize(10.0))!, range: NSMakeRange(0, placeholderText.characters.count))

ethPlaceholderTextView.text = ""
ethPlaceholderTextView.attributedPlaceholder = attributedString
