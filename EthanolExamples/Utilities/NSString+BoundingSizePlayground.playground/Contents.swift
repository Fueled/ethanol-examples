import EthanolUtilities
import XCPlayground
/*:
# NSString+BoundingSize Playground
This category provides handful methods to calculate the exact size of a text according to its font and to the font size.
You can notably specify a fixed width and variable height, fixed height and variable width, or both width and height variable
(which will basically consider that the string is in one line only).
*/

// Create the String
let string = "I am a very long string, I am a very long string, I am a very long string, I am a very long string, I am a very long string, Yes I am."

// Get size withoug specifying any width (equivalent to variable width and height).
// The size returned corresponds to the size of this text written in one line only.
(string as NSString).eth_boundingSizeWithSize(UIFont(name: "HelveticaNeue-UltraLight", size: 12.0))

// Get size with fixed width: will etend vertically if needed (most common case)
(string as NSString).eth_boundingSizeWithSize(CGSize(width: 100.0, height: Double(COMPUTE_BOUND)), font: UIFont(name: "HelveticaNeue-UltraLight", size: 12.0))

// Get size with fixed height: will extend horizontally if needed
(string as NSString).eth_boundingSizeWithSize(CGSize(width: Double(COMPUTE_BOUND), height: 100.0), font: UIFont(name: "HelveticaNeue-UltraLight", size: 12.0))

// It is even possible to specify the text alignment (does not differ most of the times)
(string as NSString).eth_boundingSizeWithSize(CGSize(width: 100.0, height: Double(COMPUTE_BOUND)), font: UIFont(name: "HelveticaNeue-UltraLight", size: 12.0), textAlignment: .Justified)
