
import EthanolUIComponents
import EthanolValidationFormatting

/*:
# ETHTextField Playground
Learn how to use ETHTextField in your project and enjoy its numerous benefits such as:
* String Validation
* String Formatting
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
USA State Validator
*/

// Set Validator
ethTextfield.validator = ETHUSAStateValidator()

// Valid US State
ethTextfield.text = "NY"
ethTextfield.validateInput()

// Invalid US State, catch error
ethTextfield.text = "Random Text"
do {
  try ethTextfield.validator?.validateObject(ethTextfield.text)
} catch {
  error
}

/*:
Non Empty Validator
*/

// Set Validator
ethTextfield.validator = ETHNonemptyValidator()

// Valid Non Empty Field
ethTextfield.text = "Some Text"
ethTextfield.validateInput()

/*:
Credit Card Validator
*/

/*:
 Validator
*/

/*:
# Formatters
*/
/*:
Credit Card Validator
*/

/*:
Phone Number Validator
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
