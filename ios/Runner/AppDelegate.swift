import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyB78dEYQMPHn12F5EQaXTZAbqBOG5ccYFg")
    // GMSPlacesClient.provideAPIKey("AIzaSyB78dEYQMPHn12F5EQaXTZAbqBOG5ccYFg")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
