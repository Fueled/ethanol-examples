
import EthanolUIComponents

/*:
# ETHPageControl Playground
ETHPageControl is a remake of UIPageControl providing a couple of really handy customizations. ETHPageControl is not a subclass of UIPageControl, but it implements the same methods (with very same method signatures) in order to offer the same public interface as UIPageControl (with additional new handy properties and methods). Learn here how to enjoy its enhancements:
* Change dynamically the distance between the dots
* Set custom images instead of default dots
-----
__Tip:__ ETHPageControl supports IBDesignable and IBInspectable for its properties. The rendering in XIB files and Storyboards can sometimes be messed up on XCode (do not show default dots, their position can be weird, among others), but don't worry, the final view will behave as expected!
*/

// Create the ETHPageControl
let ethPageControl = ETHPageControl(frame: CGRectMake(0.0, 0.0, 200.0, 30.0))

// Set arbitrary number of pages and current page
ethPageControl.numberOfPages = 5
ethPageControl.currentPage = 1

// Change colors for better visibility (test purpose)
ethPageControl.backgroundColor = UIColor.grayColor()
ethPageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
ethPageControl.currentPageIndicatorTintColor = UIColor.whiteColor()

/*:
## Distance Between Dots
ETHPageControl allows you to change dynamically the distance between the dots, whether they are the default or custom ones.
As you change the value of this property, you will see the dots move directly on the view.
*/

ethPageControl.dotsSpace = 2.0

ethPageControl.dotsSpace = 5.0

ethPageControl.dotsSpace = 20.0

/*:
## Custom Dots
This is the main reason why developers need to subclass UIPageControl, whenever projects impose us to use custom images in place of the default dots. UIPageControl doesn't provide anything handy to handle that.
With ETHPageControl, you will be able to specify your custom unselected/current dot images. Even better, you will be able to set different images for the very left dot as well as the very right one.
Everything is totally customable and very easy to use.

Different properties you will want to deal with:
* __middleDotImageActive__ and __middleDotImageInactive__: images used for inactive and active states, for all dots except very left one and very right one.
* __leftDotImageActive__ and __leftFotImageInactive__: images used for inactive and active states, very left dot only
* __rightDotImageActive__ and __rightFotImageInactive__: images used for inactive and active states, very right dot only
*/

// Create images for tests
let middleDotActive = UIImage(named: "Carousel-Middle-Active")
let middleDotInactive = UIImage(named: "Carousel-Middle-Inactive")

let leftDotActive = UIImage(named: "Carousel-Left-Active")
let leftDotInactive = UIImage(named: "Carousel-Left-Inactive")

let rightDotActive = UIImage(named: "Carousel-Right-Active")
let rightDotInactive = UIImage(named: "Carousel-Right-Inactive")

let starDotActive = UIImage(named: "Carousel-Star-Active")

/*:
Custom images with very left and very right dots different as middle dots
*/
ethPageControl.middleDotImageActive = middleDotActive
ethPageControl.middleDotImageInactive = middleDotInactive

ethPageControl.leftDotImageActive = leftDotActive
ethPageControl.leftDotImageInactive = leftDotInactive

ethPageControl.rightDotImageActive = rightDotActive
ethPageControl.rightDotImageInactive = rightDotInactive

// If only 2 pages, no middle dot will be displayed (very left dot and very right dot only)
ethPageControl.numberOfPages = 2

// If only 1 page, the only dot displayed is a middle dot
ethPageControl.numberOfPages = 1

/*:
Custom images with very left and very right dots same as middle dots.
*/

ethPageControl.numberOfPages = 5
ethPageControl.currentPage = 1

ethPageControl.middleDotImageActive = middleDotActive
ethPageControl.middleDotImageInactive = middleDotInactive

ethPageControl.leftDotImageActive = middleDotActive
ethPageControl.leftDotImageInactive = middleDotInactive

ethPageControl.rightDotImageActive = middleDotActive
ethPageControl.rightDotImageInactive = middleDotInactive

/*:
Custom images for active dots only, with very left and very right dots same as middle ones. We need to set back inactive dots to default (assign nil).
*/

ethPageControl.middleDotImageActive = starDotActive
ethPageControl.middleDotImageInactive = nil

ethPageControl.leftDotImageActive = starDotActive
ethPageControl.leftDotImageInactive = nil

ethPageControl.rightDotImageActive = starDotActive
ethPageControl.rightDotImageInactive = nil
