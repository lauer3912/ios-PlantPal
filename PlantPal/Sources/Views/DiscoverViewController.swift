import UIKit

class DiscoverViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private let collectionView: UICollectionView
    private var allPlants: [PlantSpecies] = []
    private var filteredPlants: [PlantSpecies] = []
    private var selectedFilter: String = "All"
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPlantDatabase()
    }
    
    private func setupUI() {
        view.backgroundColor = ThemeService.shared.backgroundColor
        title = "Discover"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchBar.placeholder = "Search plants..."
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = ThemeService.shared.backgroundColor
        view.addSubview(searchBar)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: "DiscoverCell")
        view.addSubview(collectionView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadPlantDatabase() {
        allPlants = PlantDatabase.shared.getAllSpecies()
        filteredPlants = allPlants
        collectionView.reloadData()
    }
}

extension DiscoverViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredPlants = allPlants
        } else {
            filteredPlants = allPlants.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.scientificName.lowercased().contains(searchText.lowercased())
            }
        }
        collectionView.reloadData()
    }
}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPlants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCell
        cell.configure(with: filteredPlants[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 52) / 2
        return CGSize(width: width, height: width * 0.8 + 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let plant = filteredPlants[indexPath.item]
        let alert = UIAlertController(title: plant.name, message: "\(plant.scientificName)\n\n\(plant.description)\nCare Level: \(plant.careLevel.rawValue)\nLight: \(plant.lightNeeds.rawValue)\nPet Safe: \(plant.isPetSafe ? "Yes" : "No")", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Add to My Plants", style: .default) { [weak self] _ in
            self?.addPlantToCollection(plant)
        })
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alert, animated: true)
    }
    
    private func addPlantToCollection(_ species: PlantSpecies) {
        let plant = Plant(
            id: UUID().uuidString,
            name: species.name,
            nickname: nil,
            species: species.name,
            breed: species.scientificName,
            photoURLs: [],
            location: .livingRoom,
            birthdate: nil,
            addedDate: Date(),
            healthScore: 100,
            careLevel: species.careLevel,
            lightNeeds: species.lightNeeds,
            wateringFrequency: species.wateringFrequencyDays,
            lastWatered: nil,
            lastFertilized: nil,
            lastRepotted: nil,
            isPetSafe: species.isPetSafe,
            notes: nil
        )
        DataService.shared.addPlant(plant)
        
        let confirmAlert = UIAlertController(title: "Added!", message: "\(plant.name) has been added to your collection.", preferredStyle: .alert)
        confirmAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(confirmAlert, animated: true)
    }
}

class DiscoverCell: UICollectionViewCell {
    private let containerView = UIView()
    private let iconView = UIImageView()
    private let nameLabel = UILabel()
    private let scientificLabel = UILabel()
    private let careLevelLabel = UILabel()
    private let safetyBadge = UIView()
    private let safetyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = ThemeService.shared.surfaceColor
        contentView.layer.cornerRadius = 16
        
        iconView.contentMode = .scaleAspectFit
        iconView.image = UIImage(systemName: "leaf.fill")
        iconView.tintColor = ThemeService.shared.colors.primary
        contentView.addSubview(iconView)
        
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        nameLabel.textColor = ThemeService.shared.textPrimary
        nameLabel.numberOfLines = 2
        contentView.addSubview(nameLabel)
        
        scientificLabel.font = .italicSystemFont(ofSize: 12)
        scientificLabel.textColor = ThemeService.shared.textSecondary
        contentView.addSubview(scientificLabel)
        
        careLevelLabel.font = .systemFont(ofSize: 11)
        careLevelLabel.textColor = ThemeService.shared.textSecondary
        contentView.addSubview(careLevelLabel)
        
        safetyBadge.layer.cornerRadius = 8
        safetyBadge.backgroundColor = ThemeService.shared.colors.success.withAlphaComponent(0.2)
        safetyBadge.isHidden = true
        contentView.addSubview(safetyBadge)
        
        safetyLabel.font = .systemFont(ofSize: 10, weight: .medium)
        safetyLabel.textColor = ThemeService.shared.colors.success
        safetyBadge.addSubview(safetyLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        scientificLabel.translatesAutoresizingMaskIntoConstraints = false
        careLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        safetyBadge.translatesAutoresizingMaskIntoConstraints = false
        safetyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 40),
            iconView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            scientificLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            scientificLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            scientificLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            careLevelLabel.topAnchor.constraint(equalTo: scientificLabel.bottomAnchor, constant: 8),
            careLevelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            safetyBadge.topAnchor.constraint(equalTo: careLevelLabel.topAnchor),
            safetyBadge.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            safetyBadge.widthAnchor.constraint(equalToConstant: 50),
            safetyBadge.heightAnchor.constraint(equalToConstant: 16),
            
            safetyLabel.centerXAnchor.constraint(equalTo: safetyBadge.centerXAnchor),
            safetyLabel.centerYAnchor.constraint(equalTo: safetyBadge.centerYAnchor)
        ])
    }
    
    func configure(with species: PlantSpecies) {
        nameLabel.text = species.name
        scientificLabel.text = species.scientificName
        careLevelLabel.text = species.careLevel.rawValue
        
        safetyBadge.isHidden = !species.isPetSafe
        if species.isPetSafe {
            safetyLabel.text = "Safe"
        }
    }
}
