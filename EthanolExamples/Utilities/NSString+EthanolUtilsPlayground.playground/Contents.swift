import EthanolUtilities
import EthanolValidationFormatting
/*:
# NSString+EthanolUtils Playground
One of the most widely used objects in the iOS world is obviously NSString. There always are situations where developers will need to deal with strings.
This category provides helpful helper methods that will allow you to save a lot of time, such as:
* Check if contains substring
* Get string by removing characters (can possibly preserve cursor)
*/

/*:
## Contains Substring
This method will allow you to check if a given substring is contained in another string. Returns a boolean.
*/

// String contains substring
let string = "I am a string containing the substring"
(string as NSString).eth_containsSubstring("substring")

// String does not contain substring
(string as NSString).eth_containsSubstring("subbstring")

/*:
## Remove characters
This method will allow you to remove specific characters from a given string.
Two methods are provided, both return a copy of the string (whether they remove characters or not).
One method returns the string with arbitrary cursor, the other one preserves a specific cursor provided by the user.
*/

// Regular remove characters
(string as NSString).eth_stringByRemovingCharacters(NSCharacterSet(charactersInString: "aeiouy"))
string

// Remove characters with specified preserved cursor.
// If cursor nil, will have same behavior as above.
var cursorPointer: Int = 10
(string as NSString).eth_stringByRemovingCharacters(NSCharacterSet(charactersInString: "bcdfghjklmnpqrstvw"), preserveCursor: &cursorPointer)
cursorPointer
string
