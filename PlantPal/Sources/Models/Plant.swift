import Foundation

struct Plant: Codable, Identifiable {
    let id: String
    var name: String
    var nickname: String?
    var species: String
    var breed: String?
    var photoURLs: [String]
    var location: PlantLocation
    var birthdate: Date?
    var addedDate: Date
    var healthScore: Int
    var careLevel: CareLevel
    var lightNeeds: LightLevel
    var wateringFrequency: Int
    var lastWatered: Date?
    var lastFertilized: Date?
    var lastRepotted: Date?
    var isPetSafe: Bool
    var notes: String?
    
    var displayName: String {
        nickname ?? name
    }
    
    var daysSinceLastWatered: Int? {
        guard let lastWatered = lastWatered else { return nil }
        return Calendar.current.dateComponents([.day], from: lastWatered, to: Date()).day
    }
    
    var needsWatering: Bool {
        guard let days = daysSinceLastWatered else { return true }
        return days >= wateringFrequency
    }
}

enum PlantLocation: String, Codable, CaseIterable {
    case bedroom = "Bedroom"
    case bathroom = "Bathroom"
    case kitchen = "Kitchen"
    case livingRoom = "Living Room"
    case office = "Office"
    case balcony = "Balcony"
    case garden = "Garden"
    case other = "Other"
}

enum CareLevel: String, Codable, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case expert = "Expert"
    
    var description: String {
        switch self {
        case .easy: return "Great for beginners"
        case .medium: return "Some experience needed"
        case .expert: return "For experienced plant parents"
        }
    }
}

enum LightLevel: String, Codable, CaseIterable {
    case low = "Low Light"
    case medium = "Medium Light"
    case bright = "Bright Indirect"
    case direct = "Direct Sunlight"
    
    var icon: String {
        switch self {
        case .low: return "moon.fill"
        case .medium: return "cloud.sun.fill"
        case .bright: return "sun.max.fill"
        case .direct: return "sun.max.circle.fill"
        }
    }
}

struct CareTask: Codable, Identifiable {
    let id: String
    let plantId: String
    let type: CareTaskType
    let dueDate: Date
    var isCompleted: Bool
    var completedDate: Date?
    
    var isOverdue: Bool {
        !isCompleted && dueDate < Date()
    }
}

enum CareTaskType: String, Codable, CaseIterable {
    case water = "Water"
    case fertilize = "Fertilize"
    case repot = "Repot"
    case prune = "Prune"
    case rotate = "Rotate"
    
    var icon: String {
        switch self {
        case .water: return "drop.fill"
        case .fertilize: return "leaf.fill"
        case .repot: return "square.and.arrow.down.fill"
        case .prune: return "scissors"
        case .rotate: return "arrow.triangle.2.circlepath"
        }
    }
    
    var color: String {
        switch self {
        case .water: return "#3B82F6"
        case .fertilize: return "#22C55E"
        case .repot: return "#F59E0B"
        case .prune: return "#8B5CF6"
        case .rotate: return "#EC4899"
        }
    }
}

struct PlantSpecies: Codable, Identifiable {
    let id: String
    let name: String
    let scientificName: String
    let careLevel: CareLevel
    let lightNeeds: LightLevel
    let wateringFrequencyDays: Int
    let humidity: HumidityLevel
    let temperature: TemperatureRange
    let isPetSafe: Bool
    let description: String
    let careTips: [String]
    let commonProblems: [String]
}

enum HumidityLevel: String, Codable, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    var icon: String {
        switch self {
        case .low: return "humidity"
        case .medium: return "humidity.fill"
        case .high: return "drop.degreesign.fill"
        }
    }
}

struct TemperatureRange: Codable {
    let min: Int
    let max: Int
    let ideal: Int
    
    var display: String {
        "\(min)-\(max)°F (ideal: \(ideal°F))"
    }
}

struct UserProfile: Codable {
    var name: String?
    var plantCount: Int
    var premiumExpires: Date?
    var notificationsEnabled: Bool
    var preferredTheme: String?
    var onboardingCompleted: Bool
    
    var isPremium: Bool {
        guard let expires = premiumExpires else { return false }
        return expires > Date()
    }
}
