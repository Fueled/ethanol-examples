
import EthanolUIComponents
import EthanolValidationFormatting

/*:
# ETHTextField Playground
Learn how to use ETHTextField in your project and enjoy its numerous benefits such as:
* String Validation
* String Formattingg
* Convenience Properties
* And many others.
*/

var ethTextfield = ETHTextField(frame: CGRectMake(0.0, 0.0, 400.0, 50.0))
ethTextfield.textAlignment = .Center

/*:
# Validators
How to process?
* Instantiate your ETHTextField's __validator__ property.
* Call __validateInput()__ or __validateInputSilently()__ whenever you need to test your field's text accuracy.
* Implement ETHTextFieldDelegate method *textField:didValidateText:withReason:withSuccess:error:* that will catch this call and handle validation.

Good to know:
* ETHTextFieldDelegate method *textField:shouldValidateText:forReason:* returns *true* by default.
* validateInputSilently() will never trigger the ETHTextFieldDelegate methods *textField:shouldValidateText:forReason:* and *textField:didValidateText:withReason:withSuccess:error:* to be called.
*/
/*:
__Non Empty Validator__
A non empty string such as *textfield.length == 0*
*/

// Set Validator
ethTextfield.validator = ETHNonemptyValidator()

// Valid Non Empty Field
ethTextfield.text = "Some Text"
do {
  try ethTextfield.validator?.validateObject(ethTextfield.text)
} catch {
  error
}

// Invalid Non Empty Field
ethTextfield.text = ""
ethTextfield.validateInput()

/*:
__Numeric Text Validator__
Can only contain numbers.
*/

// Set Validator
ethTextfield.validator = ETHSelectorValidator(selector: NSSelectorFromString("eth_isAlphabetic"), error: nil)

// Valid Numeric Text
ethTextfield.text = "abc"
ethTextfield.validateInput()

// Invalid Alphanumeric Text
ethTextfield.text = "ab3"
ethTextfield.validateInput()

/*:
__Alphabetic Text Validator__
Can only contain letters.
*/

// Set Validator
ethTextfield.validator = ETHSelectorValidator(selector: NSSelectorFromString("eth_isNumeric"), error: nil)

// Valid Numeric Text
ethTextfield.text = "23"
ethTextfield.validateInput()

// Invalid Alphanumeric Text
ethTextfield.text = "23a"
ethTextfield.validateInput()

/*:
__Alphanumeric Text Validator__
Can only contain letters and numbers.
*/

// Set Validator
ethTextfield.validator = ETHSelectorValidator(selector: NSSelectorFromString("eth_isAlphanumeric"), error: nil)

// Valid Alphanumeric Text
ethTextfield.text = "2a46f47hs43"
ethTextfield.validateInput()

// Invalid Alphanumeric Text
ethTextfield.text = "2a46f4'7hs43"
ethTextfield.validateInput()

/*:
__USA State Validator__
An USA State indicator in two letters.
*/

// Set Validator
ethTextfield.validator = ETHUSAStateValidator()

// Valid US State
ethTextfield.text = "NY"
ethTextfield.validateInput()

// Invalid US State, catch error
ethTextfield.text = "Random Text"
ethTextfield.validateInput()

/*:
__Email Address Validator__
A valid email address such as *[at least 3 characters]@[at least 3 characters].[at least 2 characters]*
*/

// Set Validator with custom error message
// error argument can be nil
ethTextfield.validator = ETHSelectorValidator(selector: NSSelectorFromString("eth_isValidEmail"), error: "This email address is invalid!")

// Valid Non Empty Field
ethTextfield.text = "someone@fueled.com"
ethTextfield.validateInput()

// Invalid Non Empty Field, catch error
ethTextfield.text = "thisIsInvalid.com"
do {
  try ethTextfield.validator?.validateObject(ethTextfield.text)
} catch {
  error
}

/*:
__URL Validator__
A valid URL address such as *http://[string]*
*/

// Set Validator
ethTextfield.validator = ETHSelectorValidator(selector: NSSelectorFromString("eth_isValidURL"), error: nil)

// Valid URL
ethTextfield.text = "http://fueled.com"
ethTextfield.validateInput()

// Invalid URL
ethTextfield.text = "www.fueled.com"
ethTextfield.validateInput()

/*:
__Password Validator__
A valid password is a string with *length >= 6*
*/

// Set Validator
ethTextfield.validator = ETHSelectorValidator(selector: NSSelectorFromString("eth_isValidPassword"), error: nil)

// Valid Password
ethTextfield.text = "I'm a pretty good password, am I not?"
ethTextfield.validateInput()

// Invalid Password
ethTextfield.text = "Short"
ethTextfield.validateInput()

/*:
__Credit Card Expiration Date Validator__
A valid credit card expiration date such as *month number/year number* and is not a past date.
*/

// Set Validator
ethTextfield.validator = ETHSelectorValidator(selector: NSSelectorFromString("eth_isValidCreditCardExpirationDate"), error: nil)

// Valid Credit Card Expiration Date, Sept 9th, don't forget the slash!
ethTextfield.text = "09/2030"
ethTextfield.validateInput()

// Invalid Credit Card Expiration Date: we forgot the slash
ethTextfield.text = "092015"
ethTextfield.validateInput()

// Invalid Credit Card Expiration Date: not enough characters
ethTextfield.text = "09/201"
ethTextfield.validateInput()

// Invalid Credit Card Expiration Date: past date (both month and year sensitive)
ethTextfield.text = "09/2014"
ethTextfield.validateInput()

/*:
__Credit Card Number Validator__
A valid credit card number is a string such as *12 <= length <= 20*
It's not because you have the right number of characters that a credit card number will be valid. Its sequence also has to be valid (a calculation is made to determine that).
It doesn't matter if the credit card number has spaces, letters or exotic characters: they will be deleted by Ethanol so that only the numeric ones are considered. The length limit afore-mentioned only takes numeric characters into account.
*/

// Set Validator
ethTextfield.validator = ETHSelectorValidator(selector: NSSelectorFromString("eth_isValidCreditCardNumber"), error: nil)

// Valid Credit Card Number: American Express with spaces
ethTextfield.text = "3782 8224 63100 05"
ethTextfield.validateInput()

// Valid Credit Card Number: VISA without spaces
ethTextfield.text = "4111111111111111"
ethTextfield.validateInput()

// Valid Credit Card Number: VISA with spaces and other characters (removed, not taken into consideration by Ethanol)
ethTextfield.text = "4111 a 1111 b 1111 c 1111 d"
ethTextfield.validateInput()

// Invalid Credit Card Number: too short
ethTextfield.text = "4111111"
ethTextfield.validateInput()

// Invalid Credit Card Number: right length but invalid sequence
ethTextfield.text = "1445 2512 3462 4632"
ethTextfield.validateInput()

/*:
__Credit Card Verification Code Validator__
A valid credit card verification code is only composed by numbers, and such as *3 <= length <= 4*
*/

// Set Validator
ethTextfield.validator = ETHSelectorValidator(selector: NSSelectorFromString("eth_isValidCardVerificationCode"), error: nil)

// Valid Credit Card Verification Code: 3 characters
ethTextfield.text = "222"
ethTextfield.validateInput()

// Valid Credit Card Verification Code: 4 characters
ethTextfield.text = "9089"
ethTextfield.validateInput()

// Invalid Credit Card Verification Code: 5 characters
ethTextfield.text = "90898"
ethTextfield.validateInput()

// Invalid Credit Card Verification Code: contains a non-numeric character
ethTextfield.text = "22a"
ethTextfield.validateInput()

/*:
# Formatters
*/
/*:
__Credit Card Formatter__
Formats your credit card number for a text field, adding spaces as follows:
*American Express 4-6-5 (20 digits)
*VISA 4-4-4-4 (16 digits)
If the length > 20 digits, the beginning of the string will keep the American Express formatting, and the extra digits will be added without any space formatting.
*/

// American Express Credit Card Number
ethTextfield.text = "378282246310005"

// Set Formatter
ethTextfield.formatter = ETHCreditCardNumberFormatter()

// VISA Credit Card Number
ethTextfield.text = "4111111111111111"

// Set Formatter
ethTextfield.formatter = ETHCreditCardNumberFormatter()

// What happens if the number of characters exceeds 20 (considered as the maximum, for American Express credit card numbers).
ethTextfield.text = "37828224631000566666"

// Set Formatter
ethTextfield.formatter = ETHCreditCardNumberFormatter()

/*:
__Credit Card Formatter__
Formats your credit card expiration number for a text field, adding a slash between month and year as follows: [2 digts for month]/[as many digits as you want for year, preferably 2 or 4]
If the length > 3 digits excluding auto added slash, the beginning of the string will keep its format, and the extra digits will be added without any particular formatting.
*/

// Set Formatter
ethTextfield.formatter = ETHCreditCardExpirationDateFormatter()

// Regular Credit Card Expiration Number
ethTextfield.text = "09/2030"

// Short Credit Card Expiration Number
ethTextfield.text = "09/30"

// What appens if the Credit Card Expiration Number exceeds the regular length
ethTextfield.text = "09/306666666666"



/*: WORK IN PROGRESS
To be completed soon.*/

/*:
__Phone Number Validator__
Formats your textfield text to conform official and international phone number conventions.
Will automatically add a space after the country code if provided, parenthesis for american number, and obviously regular spacing spaces.
If too many numbers, special formatting will be removed altogether.
*/

/*
// Set Formatter
ethTextfield.formatter = 

// European Phone Number: without zone code
ethTextfield.text = "0668606893"

// European Phone Number: with zone code
ethTextfield.text = "+33668606893"

// American Phone Number
ethTextfield.text = "1668606893"
*/
/*:
# Convenience Properties
*/
/*:
Max Length
*/

/*:
Limit characters typable
*/
