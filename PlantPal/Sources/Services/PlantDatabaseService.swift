import Foundation

class PlantDatabaseService {
    static let shared = PlantDatabaseService()
    
    private var speciesCache: [PlantSpecies]?
    
    func loadSpecies(completion: @escaping ([PlantSpecies]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let cached = self.speciesCache {
                completion(cached)
            } else {
                let species = self.generatePlantDatabase()
                self.speciesCache = species
                completion(species)
            }
        }
    }
    
    func getAllSpecies() -> [PlantSpecies] {
        if let cached = speciesCache {
            return cached
        }
        let species = generatePlantDatabase()
        speciesCache = species
        return species
    }
    
    private func generatePlantDatabase() -> [PlantSpecies] {
        return [
            PlantSpecies(id: "p1", name: "Monstera Deliciosa", scientificName: "Monstera deliciosa", careLevel: .easy, lightNeeds: .bright, wateringFrequencyDays: 7, humidity: .high, temperature: TemperatureRange(min: 60, max: 85, ideal: 70), isPetSafe: false, description: "The Swiss Cheese Plant is beloved for its dramatic foliage with natural holes.", careTips: ["Wipe leaves monthly", "Provide moss pole for climbing", "Rotate occasionally"], commonProblems: ["Yellow leaves from overwatering", "Brown edges from low humidity"]),
            
            PlantSpecies(id: "p2", name: "Snake Plant", scientificName: "Sansevieria trifasciata", careLevel: .easy, lightNeeds: .low, wateringFrequencyDays: 14, humidity: .low, temperature: TemperatureRange(min: 50, max: 85, ideal: 70), isPetSafe: false, description: "Nearly indestructible, the Snake Plant thrives on neglect.", careTips: ["Let soil dry completely", "Tolerates low light", "Clean leaves occasionally"], commonProblems: ["Root rot from overwatering", "Mushy leaves"]),
            
            PlantSpecies(id: "p3", name: "Pothos", scientificName: "Epipremnum aureum", careLevel: .easy, lightNeeds: .medium, wateringFrequencyDays: 7, humidity: .medium, temperature: TemperatureRange(min: 60, max: 80, ideal: 70), isPetSafe: false, description: "A trailing vine perfect for beginners and hanging baskets.", careTips: ["Trim to encourage bushier growth", "Can grow in water", "Tolerates various light levels"], commonProblems: ["Brown leaf tips from low humidity", "Leggy growth from low light"]),
            
            PlantSpecies(id: "p4", name: "Fiddle Leaf Fig", scientificName: "Ficus lyrata", careLevel: .expert, lightNeeds: .bright, wateringFrequencyDays: 10, humidity: .high, temperature: TemperatureRange(min: 60, max: 75, ideal: 68), isPetSafe: false, description: "Instagram's favorite houseplant with large violin-shaped leaves.", careTips: ["Rotate weekly", "Maintain consistent watering", "Keep away from drafts"], commonProblems: ["Brown spots from overwatering", "Dropping leaves from stress"]),
            
            PlantSpecies(id: "p5", name: "Spider Plant", scientificName: "Chlorophytum comosum", careLevel: .easy, lightNeeds: .medium, wateringFrequencyDays: 7, humidity: .medium, temperature: TemperatureRange(min: 55, max: 80, ideal: 70), isPetSafe: true, description: "Produces adorable baby plantlets on long stems.", careTips: ["Brown tips from fluoride in water", "Appreciates occasional fertilizing", "Repot when rootbound"], commonProblems: ["Brown leaf tips from chemicals", "Pale leaves from lack of light"]),
            
            PlantSpecies(id: "p6", name: "Peace Lily", scientificName: "Spathiphyllum", careLevel: .easy, lightNeeds: .low, wateringFrequencyDays: 5, humidity: .high, temperature: TemperatureRange(min: 65, max: 80, ideal: 72), isPetSafe: false, description: "Elegant white flowers and air-purifying abilities.", careTips: ["Droops when thirsty", "Mist regularly", "Wipe leaves to remove dust"], commonProblems: ["Brown tips from dry air", "No blooms from too little light"]),
            
            PlantSpecies(id: "p7", name: "Rubber Plant", scientificName: "Ficus elastica", careLevel: .medium, lightNeeds: .bright, wateringFrequencyDays: 10, humidity: .medium, temperature: TemperatureRange(min: 60, max: 80, ideal: 70), isPetSafe: false, description: "Bold, glossy leaves in deep green or burgundy.", careTips: ["Clean leaves for max shine", "Prune to control size", "Support with stake if tall"], commonProblems: ["Leaf drop from temperature changes", "Yellow leaves from overwatering"]),
            
            PlantSpecies(id: "p8", name: "ZZ Plant", scientificName: "Zamioculcas zamiifolia", careLevel: .easy, lightNeeds: .low, wateringFrequencyDays: 21, humidity: .low, temperature: TemperatureRange(min: 60, max: 75, ideal: 68), isPetSafe: false, description: "The ultimate low-maintenance plant with waxy, dark green leaves.", careTips: ["Water only when completely dry", "Tolerates neglect", "Slow grower"], commonProblems: ["Yellow leaves from overwatering", "Stem rot"]),
            
            PlantSpecies(id: "p9", name: "Boston Fern", scientificName: "Nephrolepis exaltata", careLevel: .medium, lightNeeds: .medium, wateringFrequencyDays: 3, humidity: .high, temperature: TemperatureRange(min: 55, max: 75, ideal: 65), isPetSafe: true, description: "Lush, feathery fronds perfect for hanging baskets.", careTips: ["Mist daily", "Use pebble tray", "Never let soil dry completely"], commonProblems: ["Crispy fronds from low humidity", "Yellow fronds from overwatering"]),
            
            PlantSpecies(id: "p10", name: "Aloe Vera", scientificName: "Aloe barbadensis", careLevel: .easy, lightNeeds: .bright, wateringFrequencyDays: 14, humidity: .low, temperature: TemperatureRange(min: 55, max: 80, ideal: 70), isPetSafe: false, description: "Medicinal succulent with soothing gel inside leaves.", careTips: ["Let soil dry completely", "Needs lots of light", "Harvest gel for skin care"], commonProblems: ["Brown tips from too much sun", "Mushy leaves from overwatering"]),
            
            PlantSpecies(id: "p11", name: "Calathea", scientificName: "Calathea orbifolia", careLevel: .expert, lightNeeds: .medium, wateringFrequencyDays: 5, humidity: .high, temperature: TemperatureRange(min: 65, max: 80, ideal: 70), isPetSafe: true, description: "Stunning striped leaves that move with the light.", careTips: ["Use filtered water", "Keep soil moist not wet", "High humidity essential"], commonProblems: ["Crispy edges from low humidity", "Curling leaves from underwatering"]),
            
            PlantSpecies(id: "p12", name: "Bird of Paradise", scientificName: "Strelitzia reginae", careLevel: .medium, lightNeeds: .bright, wateringFrequencyDays: 7, humidity: .medium, temperature: TemperatureRange(min: 60, max: 85, ideal: 75), isPetSafe: false, description: "Tropical beauty with dramatic paddle-shaped leaves.", careTips: ["Needs direct sun for blooms", "Large root system", "Wipe leaves monthly"], commonProblems: ["Splitting leaves from wind", "No blooms from insufficient light"]),
            
            PlantSpecies(id: "p13", name: "Philodendron", scientificName: "Philodendron hederaceum", careLevel: .easy, lightNeeds: .medium, wateringFrequencyDays: 7, humidity: .medium, temperature: TemperatureRange(min: 60, max: 80, ideal: 70), isPetSafe: false, description: "Classic trailing houseplant with heart-shaped leaves.", careTips: ["Trim to encourage fullness", "Easy to propagate", "Tolerates low light"], commonProblems: ["Yellow leaves from overwatering", "Leggy vines from low light"]),
            
            PlantSpecies(id: "p14", name: "String of Pearls", scientificName: "Senecio rowleyanus", careLevel: .medium, lightNeeds: .bright, wateringFrequencyDays: 14, humidity: .low, temperature: TemperatureRange(min: 50, max: 80, ideal: 70), isPetSafe: false, description: "Unique trailing succulent with pea-shaped leaves.", careTips: ["Water when pearls wrinkle", "Needs bright light", "Well-draining soil essential"], commonProblems: ["Mushy pearls from overwatering", "Shriveling from underwatering"]),
            
            PlantSpecies(id: "p15", name: "Chinese Evergreen", scientificName: "Aglaonema", careLevel: .easy, lightNeeds: .low, wateringFrequencyDays: 10, humidity: .medium, temperature: TemperatureRange(min: 60, max: 80, ideal: 70), isPetSafe: false, description: "Beautiful variegated leaves in silver, pink, or green.", careTips: ["Tolerates low light", "Let top inch dry", "Avoid cold drafts"], commonProblems: ["Brown tips from dry air", "Yellow leaves from overwatering"]),
            
            PlantSpecies(id: "p16", name: "Parlor Palm", scientificName: "Chamaedorea elegans", careLevel: .easy, lightNeeds: .low, wateringFrequencyDays: 7, humidity: .medium, temperature: TemperatureRange(min: 60, max: 80, ideal: 70), isPetSafe: true, description: "Elegant Victorian-era palm perfect for low light.", careTips: ["Mist regularly", "Brown tips normal", "Don't overwater"], commonProblems: ["Brown tips from low humidity", "Yellow fronds from overwatering"]),
            
            PlantSpecies(id: "p17", name: "Jade Plant", scientificName: "Crassula ovata", careLevel: .easy, lightNeeds: .bright, wateringFrequencyDays: 14, humidity: .low, temperature: TemperatureRange(min: 55, max: 75, ideal: 65), isPetSafe: false, description: "Lucky money tree with plump, coin-shaped leaves.", careTips: ["Full sun preferred", "Let dry between waterings", "Can live for decades"], commonProblems: ["Leaf drop from sudden temperature change", "Stretching from low light"]),
            
            PlantSpecies(id: "p18", name: "Dracaena", scientificName: "Dracaena marginata", careLevel: .easy, lightNeeds: .medium, wateringFrequencyDays: 10, humidity: .medium, temperature: TemperatureRange(min: 60, max: 80, ideal: 70), isPetSafe: false, description: "Dragon tree with spiky leaves and tree-like form.", careTips: ["Sensitive to fluoride", "Use filtered water", "Trim brown tips"], commonProblems: ["Brown tips from chemicals in water", "Soft stems from overwatering"]),
            
            PlantSpecies(id: "p19", name: "English Ivy", scientificName: "Hedera helix", careLevel: .medium, lightNeeds: .medium, wateringFrequencyDays: 5, humidity: .high, temperature: TemperatureRange(min: 50, max: 70, ideal: 60), isPetSafe: false, description: "Classic trailing vine with iconic lobed leaves.", careTips: ["Keep soil evenly moist", "Mist regularly", "Great for hanging baskets"], commonProblems: ["Spider mites in dry conditions", "Leggy growth from low light"]),
            
            PlantSpecies(id: "p20", name: "Peperomia", scientificName: "Peperomia obtusifolia", careLevel: .easy, lightNeeds: .medium, wateringFrequencyDays: 10, humidity: .medium, temperature: TemperatureRange(min: 60, max: 80, ideal: 70), isPetSafe: true, description: "Compact plant with thick, succulent-like leaves.", careTips: ["Let dry between waterings", "Well-draining soil", "Avoid direct sun"], commonProblems: ["Leaf drop from overwatering", "Soft stems from root rot"])
        ]
    }
}

class PlantDatabase {
    static let shared = PlantDatabase()
    
    func getAllSpecies() -> [PlantSpecies] {
        return PlantDatabaseService.shared.getAllSpecies()
    }
    
    func getSpecies(byId id: String) -> PlantSpecies? {
        return getAllSpecies().first { $0.id == id }
    }
    
    func searchSpecies(query: String) -> [PlantSpecies] {
        let lowercased = query.lowercased()
        return getAllSpecies().filter {
            $0.name.lowercased().contains(lowercased) ||
            $0.scientificName.lowercased().contains(lowercased)
        }
    }
    
    func filterByCareLevel(_ level: CareLevel) -> [PlantSpecies] {
        return getAllSpecies().filter { $0.careLevel == level }
    }
    
    func filterByLightNeeds(_ light: LightLevel) -> [PlantSpecies] {
        return getAllSpecies().filter { $0.lightNeeds == light }
    }
    
    func filterPetSafe() -> [PlantSpecies] {
        return getAllSpecies().filter { $0.isPetSafe }
    }
}
