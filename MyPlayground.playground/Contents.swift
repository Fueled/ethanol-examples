
import EthanolUIComponents

/*:
# ETHSwitch Playground
Learn how to use ETHSwitch in your project and enjoy the highly customable UI benefits it offers:
* Custom background color for both ON and OFF states
* Custom background images for both ON and OFF states
* Custom foreground color
*/

let ethSwitch = ETHSwitch(frame: CGRectMake(0.0, 0.0, 51.0, 31.0))

/*:
## Custom Background Colors
Specify custom background colors for ON and/or OFF state.
*/

// Set custom ON background color
ethSwitch.onTintColor = UIColor(red: 255.0/255.0, green: 47.0/255.0, blue: 47.0/255.0, alpha: 1.0)
ethSwitch.on = true

// Set custom OFF background color
ethSwitch.offTintColor = UIColor(red: 245.0/255.0, green: 250.0/255.0, blue: 79.0/255.0, alpha: 1.0)
ethSwitch.on = false

// Reset default background colors
ethSwitch.onTintColor = nil
ethSwitch.offTintColor = nil
ethSwitch.on = true

/*:
## Custom Background Images
Specify custon background images for ON and/or OFF state.
Custom background image takes priority over custom background color.
This means that if both custom background image and custom background color have been set, the custom background color won't be seen because hidden by custom background image.
However, this custom background actually exists underneath the custom background image. This color will subsequently be seen if the custom background image is not fully opaque.
*/

let image = UIImage(named: "Switch-On-BG")

// Set custom ON background image
ethSwitch.onImage = UIImage(named: "Switch-On-BG")

// Set custom OFF background image
ethSwitch.offImage = UIImage(named: "Switch-Off-BG")
ethSwitch.on = false

// We set a custom background OFF color. Note that the color is not seen because hidden by the custom background image
ethSwitch.offTintColor = UIColor(red: 245.0/255.0, green: 250.0/255.0, blue: 79.0/255.0, alpha: 1.0)

// Reset default background images. Note that the custom OFF color is now seen
ethSwitch.onImage = nil
ethSwitch.offImage = nil

/*:
## Custom Foreground Color
Specify custon foreground color (moving dot).
*/

// Set the custom foreground color
ethSwitch.thumbTintColor = UIColor.blackColor()
