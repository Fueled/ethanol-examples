import EthanolUtilities
import XCPlayground
/*:
# NSString+EthanolSecurity and NSData+EthanolSecurity Playground
Allows to hash NSString and NSData using a set of different hashers:
* MD2
* MD4
* MD5
* SHA1
* SHA256
* SHA384
* SHA512
Called on the objects directly, returns a new object hashed.
*/

// Create the String
let string = "I am a string to hash"

// Hash it using MD2
(string as NSString).eth_MD2()

// Hash it using MD5
(string as NSString).eth_MD5()

// Create the NSData
let data = NSData(bytes: [0xFF, 0xD9] as [UInt8], length: 2)

// Hash it using SHA-512
data.eth_SHA512()
