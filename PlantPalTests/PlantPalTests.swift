import XCTest
@testable import PlantPal

final class PlantPalTests: XCTestCase {
    
    func testPlantCreation() {
        let plant = Plant(
            id: "test-1",
            name: "Monstera",
            nickname: "Monty",
            species: "Monstera deliciosa",
            breed: nil,
            photoURLs: [],
            location: .livingRoom,
            birthdate: nil,
            addedDate: Date(),
            healthScore: 85,
            careLevel: .easy,
            lightNeeds: .bright,
            wateringFrequency: 7,
            lastWatered: nil,
            lastFertilized: nil,
            lastRepotted: nil,
            isPetSafe: false,
            notes: nil
        )
        
        XCTAssertEqual(plant.displayName, "Monty")
        XCTAssertTrue(plant.needsWatering)
        XCTAssertEqual(plant.careLevel, .easy)
    }
    
    func testDataServiceSaveLoad() {
        let plant = Plant(
            id: "test-2",
            name: "Snake Plant",
            nickname: nil,
            species: "Sansevieria",
            breed: nil,
            photoURLs: [],
            location: .bedroom,
            birthdate: nil,
            addedDate: Date(),
            healthScore: 90,
            careLevel: .easy,
            lightNeeds: .low,
            wateringFrequency: 14,
            lastWatered: nil,
            lastFertilized: nil,
            lastRepotted: nil,
            isPetSafe: false,
            notes: nil
        )
        
        DataService.shared.addPlant(plant)
        let plants = DataService.shared.loadPlants()
        
        XCTAssertEqual(plants.count, 1)
        XCTAssertEqual(plants[0].name, "Snake Plant")
        
        DataService.shared.deletePlant(plant.id)
    }
    
    func testCareTaskOverdue() {
        let pastDue = Date().addingTimeInterval(-86400)
        let task = CareTask(
            id: "task-1",
            plantId: "plant-1",
            type: .water,
            dueDate: pastDue,
            isCompleted: false,
            completedDate: nil
        )
        
        XCTAssertTrue(task.isOverdue)
    }
}
