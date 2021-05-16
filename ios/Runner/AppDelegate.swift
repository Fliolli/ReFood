import UIKit
import Flutter
import YandexMapsMobile
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyCRZguDFpDMVrlPy-tqJR6YSePT237eHyc")
    YMKMapKit.setApiKey("ef368b2e-62fc-4f2b-b2be-6d53c19664cf")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
