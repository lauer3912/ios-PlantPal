import UIKit

class HomeViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerLabel = UILabel()
    private let dateLabel = UILabel()
    private let tasksHeaderLabel = UILabel()
    private let tasksStackView = UIStackView()
    private let emptyStateView = UIView()
    
    private var todaysTasks: [CareTask] = []
    private var overdueTasks: [CareTask] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTasks()
    }
    
    private func setupUI() {
        view.backgroundColor = ThemeService.shared.backgroundColor
        title = "PlantPal"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addPlantTapped))
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.text = "Good morning! 🌱"
        headerLabel.font = .systemFont(ofSize: 28, weight: .bold)
        headerLabel.textColor = ThemeService.shared.textPrimary
        contentView.addSubview(headerLabel)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        dateLabel.text = dateFormatter.string(from: Date())
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = ThemeService.shared.textSecondary
        contentView.addSubview(dateLabel)
        
        tasksHeaderLabel.text = "Today's Tasks"
        tasksHeaderLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        tasksHeaderLabel.textColor = ThemeService.shared.textPrimary
        contentView.addSubview(tasksHeaderLabel)
        
        tasksStackView.axis = .vertical
        tasksStackView.spacing = 12
        contentView.addSubview(tasksStackView)
        
        setupEmptyState()
        contentView.addSubview(emptyStateView)
        
        setupConstraints()
    }
    
    private func setupEmptyState() {
        emptyStateView.isHidden = true
        
        let iconView = UIImageView(image: UIImage(systemName: "leaf.circle"))
        iconView.tintColor = ThemeService.shared.colors.primary
        iconView.contentMode = .scaleAspectFit
        emptyStateView.addSubview(iconView)
        
        let titleLabel = UILabel()
        titleLabel.text = "No plants yet!"
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = ThemeService.shared.textPrimary
        titleLabel.textAlignment = .center
        emptyStateView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Add your first plant to get started"
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = ThemeService.shared.textSecondary
        subtitleLabel.textAlignment = .center
        emptyStateView.addSubview(subtitleLabel)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            iconView.topAnchor.constraint(equalTo: emptyStateView.topAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 60),
            iconView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: emptyStateView.bottomAnchor)
        ])
    }
    
    private func setupConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        tasksHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        tasksStackView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            tasksHeaderLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24),
            tasksHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tasksHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            tasksStackView.topAnchor.constraint(equalTo: tasksHeaderLabel.bottomAnchor, constant: 16),
            tasksStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tasksStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            emptyStateView.topAnchor.constraint(equalTo: tasksHeaderLabel.bottomAnchor, constant: 40),
            emptyStateView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emptyStateView.widthAnchor.constraint(equalToConstant: 250),
            emptyStateView.heightAnchor.constraint(equalToConstant: 150),
            emptyStateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private func loadTasks() {
        todaysTasks = DataService.shared.getTasksForToday()
        overdueTasks = DataService.shared.getOverdueTasks()
        
        let allTasks = overdueTasks + todaysTasks
        emptyStateView.isHidden = !allTasks.isEmpty
        tasksStackView.isHidden = allTasks.isEmpty
        
        tasksStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for task in overdueTasks {
            let taskView = createTaskView(task, isOverdue: true)
            tasksStackView.addArrangedSubview(taskView)
        }
        
        for task in todaysTasks {
            let taskView = createTaskView(task, isOverdue: false)
            tasksStackView.addArrangedSubview(taskView)
        }
        
        if !todaysTasks.isEmpty {
            let plantCount = DataService.shared.loadPlants().count
            let hour = Calendar.current.component(.hour, from: Date())
            if hour < 12 {
                headerLabel.text = "Good morning! 🌱"
            } else if hour < 17 {
                headerLabel.text = "Good afternoon! 🌿"
            } else {
                headerLabel.text = "Good evening! 🌙"
            }
        }
    }
    
    private func createTaskView(_ task: CareTask, isOverdue: Bool) -> UIView {
        let container = UIView()
        container.backgroundColor = ThemeService.shared.surfaceColor
        container.layer.cornerRadius = 16
        container.layer.borderWidth = isOverdue ? 2 : 0
        container.layer.borderColor = ThemeService.shared.colors.error.cgColor
        
        let iconView = UIImageView()
        iconView.image = UIImage(systemName: task.type.icon)
        iconView.tintColor = UIColor(hex: task.type.color)
        iconView.contentMode = .scaleAspectFit
        container.addSubview(iconView)
        
        let titleLabel = UILabel()
        titleLabel.text = task.type.rawValue
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = ThemeService.shared.textPrimary
        container.addSubview(titleLabel)
        
        let plantNameLabel = UILabel()
        plantNameLabel.text = "Plant #\(task.plantId.prefix(4))"
        plantNameLabel.font = .systemFont(ofSize: 14)
        plantNameLabel.textColor = ThemeService.shared.textSecondary
        container.addSubview(plantNameLabel)
        
        let completeButton = UIButton(type: .system)
        completeButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        completeButton.tintColor = ThemeService.shared.colors.primary
        completeButton.tag = task.id.hashValue
        completeButton.addTarget(self, action: #selector(taskCompleted(_:)), for: .touchUpInside)
        container.addSubview(completeButton)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        plantNameLabel.translatesAutoresizingMaskIntoConstraints = false
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 70),
            
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            
            plantNameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            plantNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            
            completeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            completeButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            completeButton.widthAnchor.constraint(equalToConstant: 44),
            completeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return container
    }
    
    @objc private func taskCompleted(_ sender: UIButton) {
        let tasks = DataService.shared.loadTasks()
        if let task = tasks.first(where: { $0.id.hashValue == sender.tag }) {
            DataService.shared.completeTask(task.id)
            loadTasks()
        }
    }
    
    @objc private func addPlantTapped() {
        let alert = UIAlertController(title: "Add Plant", message: "Add your first plant!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
