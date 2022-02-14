//
//  AppDelegate.swift
//  Notifications
//
//  Created by Adrian Kumanikin on 14.02.2022.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .alert]) { (granted, error)
            in
        
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                print(settings)
                guard settings.authorizationStatus == .authorized else { return }
            }
            
        }
        
        notificationCenter.delegate = self 
        sendNotifications()
        return true
    }

    func sendNotifications() {
        
        let content = UNMutableNotificationContent()
        content.title == "First notification"
        content.body = "My first notification"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest (identifier: "Notification", content: content, trigger: trigger)
        notificationCenter.add(request) {(error) in
            print(error?.localizedDescription)
            
        }
    }
    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
        print(#function)
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print (#function)
    }
    
    
    
}
