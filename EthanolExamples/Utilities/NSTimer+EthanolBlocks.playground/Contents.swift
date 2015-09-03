import EthanolUtilities
import XCPlayground
/*:
# NSTimer+EthanolBlocks Playground
Force timer not to repeat to make sure we use a selector, when timer repeating.
A repeatable timer using a block will, if it's made to always be running, create a retain-cycle
because NSTimer retains the target. 
This category provides safer and more efficient code.
*/

// Convenience method created for test purpose
func minutesAndSecondsForDate(date: NSDate) -> String {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "mm'm' ss's'"
  println("Time: \(dateFormatter.stringFromDate(date))")
}

// Create not repeatable timer (only once)
minutesAndSecondsForDate(NSDate())
var timer1 = NSTimer.eth_timerWithTimeInterval(3.0) { timer in
  minutesAndSecondsForDate(NSDate())
}

// Create repeatable timer
minutesAndSecondsForDate(NSDate())
var timer2 = NSTimer.eth_scheduledTimerWithTimeInterval(3.0) { timer in
  minutesAndSecondsForDate(NSDate())
}

// Playground Test Code allowing for asynchronous tests, do not delete
XCPSetExecutionShouldContinueIndefinitely(true)
