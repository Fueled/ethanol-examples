import EthanolTools
import XCPlayground
/*:
# ETHPausableTimer Playground
Learn how to use ETHPausableTimer in your project and enjoy usefull benefits it provides:
* Pause and Resume your timer
* Timer keeps running in background if needed
* Init with duration, do something when finished
Note that ETHPausableTimer is not repeating (and hasn't been made for that purpose).
*/

// Convenience method created for test purpose
func minutesAndSecondsForDate(date: NSDate) -> String {
	let dateFormatter = NSDateFormatter()
	dateFormatter.dateFormat = "mm'm' ss's'"
	return "Time: \(dateFormatter.stringFromDate(date))"
}

/*:
## Initializers
A few handy initializers, both class and instance methods, are provided to you.
*/

/*: Create timer already running, executing code declared in block once done.
*/
let timer1 = ETHPausableTimer(timeInterval: 5.0, block: { (timer) -> Void in
	// Code executed once done.
	// The timeInterval has elapsed, timeInterval property is 0 and the time has been increased by 5 seconds.
	timer.timeInterval
	minutesAndSecondsForDate(NSDate())
	}, paused: false)

// Code executed right after the initializer.
// The timer is about to start.
timer1.timeInterval
minutesAndSecondsForDate(NSDate())

/*: Create timer not already running.
*/
let timer2 = ETHPausableTimer(timeInterval: 5.0, block: { (timer) -> Void in
	// Code executed once done.
	// timeInterval is now 0 because elapsed, time has been incremented by 7.5 seconds (5 seconds timer + 2.5 seconds sleep).
	timer.timeInterval
	minutesAndSecondsForDate(NSDate())
	}, paused: false)

// Start timer.
// At that point, timeInterval is not equal to 5 anymore (but slightly < 5) because the timer starts before we display that value, and it's so fast that it has time to update timeInterval. We also keep track of the current time.
timer2.resume()
timer2.timeInterval
minutesAndSecondsForDate(NSDate())

// Pause timer after 2.5 seconds
// timeInterval value has been updated accordingly. We can see comparing times that 2.5 seconds elapsed.
usleep(2500000)
timer2.pause()
timer2.timeInterval
minutesAndSecondsForDate(NSDate())

// Resume timer after 2.5 seconds, until the end
// The termination block above will be called after 5 secondes (2.5 seconds sleep + 2.5 timer seconds remaining).
usleep(2500000)
timer2.resume()
minutesAndSecondsForDate(NSDate())

/*:
Note that there is another initializer using selector: __initWithTimeInterval:target:selector:userInfo:paused:__.
*/

/*:
## Useful properties
A set of useful and handy properties will help you using the pausable timer.
*/

/*:
### forcePauseInBackground
Force pausable timer to stop when the app is in the background.
This value is false by default: this means the Pausable Timer might stop if asked to while in the background, but will keep running otherwise by default.
This is a key feature of this timer, since regular NSTimer does not run in the background at all.
*/

// Force pausable timer to stop when app in the background
timer2.forcePauseInBackground = true

/*:
### timeInterval
Time left before the timer finishes and calls back/performs selector.
*/

// timer2 current time elapsed
timer2.timeInterval

/*:
### paused
With getter isPaused, read only property that tells you if the timer is currently paused.
*/

// Is timer2 paused?
timer2.paused

/*:
### userInfo
Allows to attach some data to the timer.
*/

// Attach a String to the timer that will be used by the app
timer2.userInfo = "data related to the timer"

// Playground Test Code allowing for asynchronous tests, do not delete
XCPSetExecutionShouldContinueIndefinitely(true)

