import EthanolUtilities
import XCPlayground
/*:
# EthanolSwiftHelper Playground
Provide you handy methods that delays block execution
*/

// Convenience method created for test purpose
func minutesAndSecondsForDate(date: NSDate) -> String {
  let dateFormatterMinutes = NSDateFormatter()
  let dateFormatterSeconds = NSDateFormatter()
  dateFormatterMinutes.dateFormat = "mm"
  dateFormatterSeconds.dateFormat = "ss"
  return "Time: \(dateFormatterMinutes.stringFromDate(date))m \(dateFormatterSeconds.stringFromDate(date))s"
}

/*
## Delay execution of block
Wait for a given amount of time before running code declared in block.
Implemented in *EthanolSwiftHelpers*.
*/

minutesAndSecondsForDate(NSDate())
delay(3.0) {
  minutesAndSecondsForDate(NSDate())
}

// Playground Test Code allowing for asynchronous tests, do not delete
XCPSetExecutionShouldContinueIndefinitely(true)
