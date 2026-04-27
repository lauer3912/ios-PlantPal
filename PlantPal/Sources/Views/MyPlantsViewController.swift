import UIKit

class MyPlantsViewController: UIViewController {
    
    private let collectionView: UICollectionView
    private var plants: [Plant] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPlants()
    }
    
    private func setupUI() {
        view.backgroundColor = ThemeService.shared.backgroundColor
        title = "My Plants"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addPlantTapped))
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PlantCell.self, forCellWithReuseIdentifier: "PlantCell")
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadPlants() {
        plants = DataService.shared.loadPlants()
        collectionView.reloadData()
    }
    
    @objc private func addPlantTapped() {
        let alert = UIAlertController(title: "Add Plant", message: "Coming soon! Use the Identify tab to add plants.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension MyPlantsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlantCell", for: indexPath) as! PlantCell
        cell.configure(with: plants[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 56) / 2
        return CGSize(width: width, height: width + 60)
    }
}

class PlantCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let speciesLabel = UILabel()
    private let healthIndicator = UIView()
    
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
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = ThemeService.shared.colors.primary.withAlphaComponent(0.1)
        imageView.image = UIImage(systemName: "leaf.fill")
        imageView.tintColor = ThemeService.shared.colors.primary
        contentView.addSubview(imageView)
        
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = ThemeService.shared.textPrimary
        contentView.addSubview(nameLabel)
        
        speciesLabel.font = .systemFont(ofSize: 13)
        speciesLabel.textColor = ThemeService.shared.textSecondary
        contentView.addSubview(speciesLabel)
        
        healthIndicator.layer.cornerRadius = 5
        contentView.addSubview(healthIndicator)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        healthIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            speciesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            speciesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            healthIndicator.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 6),
            healthIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            healthIndicator.widthAnchor.constraint(equalToConstant: 10),
            healthIndicator.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    func configure(with plant: Plant) {
        nameLabel.text = plant.displayName
        speciesLabel.text = plant.species
        
        if plant.healthScore >= 80 {
            healthIndicator.backgroundColor = ThemeService.shared.colors.success
        } else if plant.healthScore >= 50 {
            healthIndicator.backgroundColor = ThemeService.shared.colors.warning
        } else {
            healthIndicator.backgroundColor = ThemeService.shared.colors.error
        }
    }
}
