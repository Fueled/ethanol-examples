import EthanolUtilities
import XCPlayground
/*:
# EthanolArrayUtilities Playground
This helper will provide you handy methods such as:
* Find an object using predicate in an Array
* Keep a given range of an Array (returns new array, or mutates existing)
*/

/*:
## Find Object In Array With Predicate
Implemented in *EthanolArrayUtilities*. Extension of SequenceType protocol.
*/

let arrayOfElements1 = ["elt1", "elt2", "elt3", "elt4"]
let indexFound = arrayOfElements1.find({ $0 == "elt3" })
indexFound

let indexNotFound = arrayOfElements1.find({ $0 == "elt5" })
indexNotFound

/*:
## Keep range of Array
Returns new array with items corresponding to specified Range.
Implemented in *EthanolArrayUtilities*. Extension of Array class.
*/

// Keep range from index 2 to 3
let arrayOfElements2 = ["elt1", "elt2", "elt3", "elt4", "elt5", "elt6"]
let range1 = 2..<4 as Range<Int>
arrayOfElements2.keepRange(range1)

// Keep range from index 2 to 8. Since only 6 elements, will just return elements until the end of the array
let arrayOfElements3 = ["elt1", "elt2", "elt3", "elt4", "elt5", "elt6"]
let range2 = 2..<8 as Range<Int>
arrayOfElements2.keepRange(range2)

// The arrays are unchanged
print(arrayOfElements2.description)
print(arrayOfElements3.description)

/*
## Keep range of Array in place
Mutates current array to keep only items specified in Range.
Implemented in *EthanolArrayUtilities*. Extension of Array class.
*/

// Keep range from index 2 to 8. Since only 6 elements, will just return elements until the end of the array
var arrayOfElements4 = ["elt1", "elt2", "elt3", "elt4", "elt5", "elt6"]
let range3 = 2..<4 as Range<Int>
arrayOfElements4.keepRangeInPlace(range3)

// The array has been mutated
print(arrayOfElements4.description)
