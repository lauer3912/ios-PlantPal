import Foundation

class DataService {
    static let shared = DataService()
    
    private let plantsKey = "savedPlants"
    private let tasksKey = "careTasks"
    private let profileKey = "userProfile"
    private let settingsKey = "appSettings"
    
    // MARK: - Plants
    func savePlants(_ plants: [Plant]) {
        if let data = try? JSONEncoder().encode(plants) {
            UserDefaults.standard.set(data, forKey: plantsKey)
        }
    }
    
    func loadPlants() -> [Plant] {
        guard let data = UserDefaults.standard.data(forKey: plantsKey),
              let plants = try? JSONDecoder().decode([Plant].self, from: data) else {
            return []
        }
        return plants
    }
    
    func addPlant(_ plant: Plant) {
        var plants = loadPlants()
        plants.append(plant)
        savePlants(plants)
    }
    
    func updatePlant(_ plant: Plant) {
        var plants = loadPlants()
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index] = plant
            savePlants(plants)
        }
    }
    
    func deletePlant(_ plantId: String) {
        var plants = loadPlants()
        plants.removeAll { $0.id == plantId }
        savePlants(plants)
    }
    
    // MARK: - Care Tasks
    func saveTasks(_ tasks: [CareTask]) {
        if let data = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(data, forKey: tasksKey)
        }
    }
    
    func loadTasks() -> [CareTask] {
        guard let data = UserDefaults.standard.data(forKey: tasksKey),
              let tasks = try? JSONDecoder().decode([CareTask].self, from: data) else {
            return []
        }
        return tasks
    }
    
    func addTask(_ task: CareTask) {
        var tasks = loadTasks()
        tasks.append(task)
        saveTasks(tasks)
    }
    
    func completeTask(_ taskId: String) {
        var tasks = loadTasks()
        if let index = tasks.firstIndex(where: { $0.id == taskId }) {
            tasks[index].isCompleted = true
            tasks[index].completedDate = Date()
            saveTasks(tasks)
        }
    }
    
    func getTasksForToday() -> [CareTask] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        return loadTasks().filter { task in
            !task.isCompleted && task.dueDate >= today && task.dueDate < tomorrow
        }
    }
    
    func getOverdueTasks() -> [CareTask] {
        return loadTasks().filter { $0.isOverdue }
    }
    
    // MARK: - User Profile
    func saveProfile(_ profile: UserProfile) {
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: profileKey)
        }
    }
    
    func loadProfile() -> UserProfile {
        guard let data = UserDefaults.standard.data(forKey: profileKey),
              let profile = try? JSONDecoder().decode(UserProfile.self, from: data) else {
            return UserProfile(name: nil, plantCount: 0, premiumExpires: nil, 
                               notificationsEnabled: true, preferredTheme: nil, onboardingCompleted: false)
        }
        return profile
    }
    
    // MARK: - Settings
    func setOnboardingCompleted(_ completed: Bool) {
        UserDefaults.standard.set(completed, forKey: "onboardingCompleted")
    }
    
    func isOnboardingCompleted() -> Bool {
        return UserDefaults.standard.bool(forKey: "onboardingCompleted")
    }
    
    // MARK: - Data Management
    func exportUserData() -> Data? {
        let exportData: [String: Any] = [
            "plants": loadPlants(),
            "tasks": loadTasks(),
            "profile": loadProfile(),
            "exportDate": Date()
        ]
        return try? JSONSerialization.data(withJSONObject: exportData, options: .prettyPrinted)
    }
    
    func clearAllData() {
        UserDefaults.standard.removeObject(forKey: plantsKey)
        UserDefaults.standard.removeObject(forKey: tasksKey)
        UserDefaults.standard.removeObject(forKey: profileKey)
        UserDefaults.standard.removeObject(forKey: settingsKey)
    }
}
