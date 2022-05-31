//
//  NotificationManager.swift
//  DripNote
//
//  Created by Bansi Mamtora on 17/06/22.
//

import UIKit
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    private var allNotesData: [AllNotesDataModel]? = [AllNotesDataModel]()
    
    func requestPermissionForNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.sound]) { [weak self] granted, error in
            guard let self = self else {
                return
            }
            if granted {
                print("granted")
                self.scheduleNotification()
            } else {
                print("error")
            }
        }
    }
    
    func scheduleNotification() {
        allNotesData = DatabaseHelper.shared.getAllNotes()
        if let allNotesData = allNotesData {
            if allNotesData.count > 0 {
                guard let randomNote = allNotesData.randomElement() else { return }
                
                let center = UNUserNotificationCenter.current()
                
                let content = UNMutableNotificationContent()
                content.title = randomNote.title
                content.body = randomNote.detail
                content.sound = .default
                
                var dateComponents = DateComponents()
                dateComponents.hour = 11
                dateComponents.minute = 00
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let triggerInterval = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)
            }
            
        }
        
    }
}
