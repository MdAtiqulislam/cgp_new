import Flutter
import UIKit
import GoogleMaps
import flutter_local_notifications


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyBprY90fvqn9LQqEhe4mSIyDf1UekyT2Po")
    GeneratedPluginRegistrant.register(with: self)

    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Optional: Implement the UNUserNotificationCenterDelegate methods only if needed
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .badge, .sound])
  }

    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    // Handle the notification response
    completionHandler()
  }
}

