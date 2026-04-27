import UIKit

class ProfileViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let sections: [(String, [SettingsItem])] = [
        ("Statistics", [
            SettingsItem(icon: "leaf.fill", title: "Total Plants", type: .info, key: "totalPlants"),
            SettingsItem(icon: "drop.fill", title: "Watering Streak", type: .info, key: "wateringStreak"),
            SettingsItem(icon: "trophy.fill", title: "Achievements", type: .navigation, key: "achievements")
        ]),
        ("Settings", [
            SettingsItem(icon: "bell.fill", title: "Notifications", type: .toggle, key: "notifications"),
            SettingsItem(icon: "moon.fill", title: "Dark Mode", type: .toggle, key: "darkMode"),
            SettingsItem(icon: "globe", title: "Language", type: .selection, key: "language")
        ]),
        ("Subscription", [
            SettingsItem(icon: "star.fill", title: "Upgrade to Premium", type: .action, key: "premium"),
            SettingsItem(icon: "creditcard.fill", title: "Manage Subscription", type: .navigation, key: "manageSub")
        ]),
        ("About", [
            SettingsItem(icon: "info.circle.fill", title: "Version 1.0.0", type: .info, key: "version"),
            SettingsItem(icon: "square.and.arrow.up", title: "Export Data", type: .action, key: "exportData"),
            SettingsItem(icon: "trash.fill", title: "Delete All Data", type: .destructive, key: "deleteData")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = ThemeService.shared.backgroundColor
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.register(SettingsToggleCell.self, forCellReuseIdentifier: "SettingsToggleCell")
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func handleAction(for item: SettingsItem) {
        switch item.key {
        case "premium":
            showPremiumScreen()
        case "exportData":
            exportData()
        case "deleteData":
            confirmDeleteData()
        default:
            break
        }
    }
    
    private func showPremiumScreen() {
        let alert = UIAlertController(title: "PlantPal Premium", message: "Unlock:\n• Unlimited plants\n• AI plant expert\n• No ads\n• Priority support\n\n$4.99/month or $39.99/year", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Monthly $4.99", style: .default) { _ in })
        alert.addAction(UIAlertAction(title: "Yearly $39.99", style: .default) { _ in })
        alert.addAction(UIAlertAction(title: "Later", style: .cancel))
        present(alert, animated: true)
    }
    
    private func exportData() {
        if let data = DataService.shared.exportUserData(),
           let jsonString = String(data: data, encoding: .utf8) {
            let activityVC = UIActivityViewController(activityItems: [jsonString], applicationActivities: nil)
            present(activityVC, animated: true)
        }
    }
    
    private func confirmDeleteData() {
        let alert = UIAlertController(title: "Delete All Data?", message: "This will permanently delete all your plants and settings. This cannot be undone.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            DataService.shared.clearAllData()
            self.tableView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].1.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].1[indexPath.row]
        
        if item.type == .toggle {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsToggleCell", for: indexPath) as! SettingsToggleCell
            cell.configure(with: item)
            cell.onToggle = { isOn in
                UserDefaults.standard.set(isOn, forKey: item.key)
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        cell.configure(with: item, value: getValue(for: item))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = sections[indexPath.section].1[indexPath.row]
        handleAction(for: item)
    }
    
    private func getValue(for item: SettingsItem) -> String? {
        switch item.key {
        case "totalPlants":
            return "\(DataService.shared.loadPlants().count)"
        case "wateringStreak":
            return "0 days"
        default:
            return nil
        }
    }
}

struct SettingsItem {
    let icon: String
    let title: String
    let type: SettingsItemType
    let key: String
}

enum SettingsItemType {
    case toggle
    case navigation
    case selection
    case action
    case destructive
    case info
}

class SettingsCell: UITableViewCell {
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = ThemeService.shared.surfaceColor
        
        iconView.tintColor = ThemeService.shared.colors.primary
        iconView.contentMode = .scaleAspectFit
        contentView.addSubview(iconView)
        
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = ThemeService.shared.textPrimary
        contentView.addSubview(titleLabel)
        
        valueLabel.font = .systemFont(ofSize: 14)
        valueLabel.textColor = ThemeService.shared.textSecondary
        contentView.addSubview(valueLabel)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor, constant: -8)
        ])
    }
    
    func configure(with item: SettingsItem, value: String?) {
        iconView.image = UIImage(systemName: item.icon)
        titleLabel.text = item.title
        valueLabel.text = value
        
        switch item.type {
        case .navigation:
            accessoryType = .disclosureIndicator
        case .destructive:
            titleLabel.textColor = ThemeService.shared.colors.error
            iconView.tintColor = ThemeService.shared.colors.error
        case .info:
            accessoryType = .none
            titleLabel.textColor = ThemeService.shared.textPrimary
        default:
            accessoryType = .none
        }
    }
}

class SettingsToggleCell: UITableViewCell {
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let toggle = UISwitch()
    
    var onToggle: ((Bool) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = ThemeService.shared.surfaceColor
        selectionStyle = .none
        
        iconView.tintColor = ThemeService.shared.colors.primary
        iconView.contentMode = .scaleAspectFit
        contentView.addSubview(iconView)
        
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = ThemeService.shared.textPrimary
        contentView.addSubview(titleLabel)
        
        toggle.onTintColor = ThemeService.shared.colors.primary
        toggle.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)
        contentView.addSubview(toggle)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        toggle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            toggle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            toggle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with item: SettingsItem) {
        iconView.image = UIImage(systemName: item.icon)
        titleLabel.text = item.title
        toggle.isOn = UserDefaults.standard.bool(forKey: item.key)
    }
    
    @objc private func toggleChanged() {
        onToggle?(toggle.isOn)
    }
}
