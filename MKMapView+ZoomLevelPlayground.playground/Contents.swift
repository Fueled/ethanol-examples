import EthanolUIExtensions
import MapKit
/*:
# MKMapView+ZoomMap Playground
Learn how to use this highly valuable catefory on MKMapView allowing you to:
* Zoom on a particular point with a given zoom by calling only one method.
* Compute distance on screen in pixels for a given real distance (according to the current zoom level).
* Compute read distance for a given distance on screen (between two points for instance, also depending on the current zoom level).
*/

let mapView = MKMapView(frame: CGRect(x: 0.0, y: 0.0, width: 400.0, height: 400.0))

/*:
## Apply Zoom
It's never been easier to set a zoom level on your Map View than now using the **zoom** property or its convenient methods.
This zoom is has a value such as **0 <= zoom <= 19**, the bigger the more the zoom is important.
*/

mapView.eth_zoomLevel = 0.0




