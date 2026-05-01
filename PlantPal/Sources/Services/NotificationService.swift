import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    private let center = UNUserNotificationCenter.current()
    private let plantReminderID = "com.ggsheng.PlantPal.plantReminder"

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in DispatchQueue.main.async { completion(granted) } }
    }

    func schedulePlantReminder(at hour: Int = 9) {
        center.removePendingNotificationRequests(withIdentifiers: [plantReminderID])
        let content = UNMutableNotificationContent()
        content.title = "🌿 PlantPal"
        content.body = "Time to check on your plants! Don't let them wilt — your green buddies need you."
        content.sound = .default
        let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: hour, minute: 0), repeats: true)
        let request = UNNotificationRequest(identifier: plantReminderID, content: content, trigger: trigger)
        center.add(request) { error in if let e = error { print("Notification error: \(e)") } }
    }

    func cancelAll() { center.removePendingNotificationRequests(withIdentifiers: [plantReminderID]) }
    var isEnabled: Bool { get { UserDefaults.standard.bool(forKey: "PlantPal.notificationsEnabled") } set { UserDefaults.standard.set(newValue, forKey: "PlantPal.notificationsEnabled") } }

    func toggle(enabled: Bool, completion: @escaping (Bool) -> Void) {
        if enabled { requestAuthorization { [weak self] granted in if granted { self?.isEnabled = true; self?.schedulePlantReminder(); completion(true) } else { completion(false) } } }
        else { isEnabled = false; cancelAll(); completion(true) }
    }
    func restoreScheduledNotifications() { if isEnabled { schedulePlantReminder() } }
}
