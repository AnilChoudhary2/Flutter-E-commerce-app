import UIKit
import Flutter
import FirebaseCore
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure() //add this before the code below
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0, *)
            {
               UNUserNotificationCenter.current().delegate = self
                UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            }
    application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

      override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
          {
              completionHandler([.alert, .badge, .sound])
          }
}
