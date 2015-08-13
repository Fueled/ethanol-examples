//: Playground - noun: a place where people can play

import EthanolUIComponents
import EthanolValidationFormatting

/*:
# ETHTextField Playground
Learn how to use ETHTextField in your project and enjoy its numerous benefits such as:
* String validation
* String formatting
* Convenience properties
* And many others.
*/

var str = "Hello, playground"

var ethTextfield = ETHTextField()

ethTextfield.text = "NY"
ethTextfield.validator = ETHUSAStateValidator()
ethTextfield.validateInput()
