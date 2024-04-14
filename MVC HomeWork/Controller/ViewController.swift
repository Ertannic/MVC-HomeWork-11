//
//  ViewController.swift
//  MVC HomeWork
//
//  Created by Ertannic Saralay on 13.04.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - UI
    private var elements: [Setting] = [
           Setting(title: "Авиарежим", imageName: "airplane.circle.fill", color: .orange, detailText: nil),
           Setting(title: "Wi-Fi", imageName: "wifi.circle.fill", color: .blue, detailText: "Не подключено"),
           Setting(title: "Bluetooth", imageName: "bolt.horizontal.circle.fill", color: .blue, detailText: "Вкл."),
           Setting(title: "Сотовая связь", imageName: "antenna.radiowaves.left.and.right.circle.fill", color: .green, detailText: nil),
           Setting(title: "Режим можема", imageName: "personalhotspot.circle.fill", color: .green, detailText: nil),
           Setting(title: "VPN", imageName: "bolt.horizontal.circle.fill", color: .blue, detailText: nil)
       ]
       
       private var secondSectionElements: [Setting] = [
           Setting(title: "Уведомления", imageName: "bell.circle.fill", color: .red, detailText: nil),
           Setting(title: "Звуки, тактильные сигналы", imageName: "speaker.wave.2.circle.fill", color: .red, detailText: nil),
           Setting(title: "Не беспокоить", imageName: "moon.circle.fill", color: .systemPurple, detailText: nil),
           Setting(title: "Экранное время", imageName: "iphone.circle.fill", color: .systemPurple, detailText: nil)
       ]
       
       private var additionalSectionElements: [Setting] = [
           Setting(title: "Основные", imageName: "gear.circle.fill", color: .gray, detailText: nil),
           Setting(title: "Пункт Управления", imageName: "slider.horizontal.3", color: .gray, detailText: nil),
           Setting(title: "Экран и Яркость", imageName: "sun.max.circle.fill", color: .blue, detailText: nil),
           Setting(title: "Экран <<Домой>>", imageName: "house.circle.fill", color: .blue, detailText: nil),
           Setting(title: "Универсальный доступ", imageName: "figure.walk", color: .blue, detailText: nil)
       ]
    
    // MARK: - UI
    private lazy var tableView: UITableView =  {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupView()
        setupConstraints()
    }

    private func setupView() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return elements.count
        case 1:
            return secondSectionElements.count
        case 2:
            return additionalSectionElements.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        switch indexPath.section {
        case 0:
            let element = elements[indexPath.row]
            cell.textLabel?.text = element.title
            cell.customImageView.image = UIImage(systemName: element.imageName)
            cell.customImageView.tintColor = element.color
            cell.customDetailTextLabel.text = element.detailText
            cell.showSwitch(element.title == "Авиарежим" || element.title == "VPN")
            cell.switchChanged = { [weak self] isOn in
                self?.handleSwitchChange(for: element.title, isOn: isOn)
            }
            if element.title != "Авиарежим" && element.title != "VPN" {
                cell.accessoryType = .disclosureIndicator
            } else {
                cell.accessoryType = .none
            }
        case 1:
            let element = secondSectionElements[indexPath.row]
            cell.textLabel?.text = element.title
            cell.customImageView.image = UIImage(systemName: element.imageName)
            cell.customImageView.tintColor = element.color
            cell.accessoryType = .disclosureIndicator
        case 2:
            let element = additionalSectionElements[indexPath.row]
            cell.textLabel?.text = element.title
            cell.customImageView.image = UIImage(systemName: element.imageName)
            cell.customImageView.tintColor = element.color
            cell.showSwitch(false)
            cell.accessoryType = .disclosureIndicator
        default:
            break
        }
        return cell
    }
    func handleSwitchChange(for title: String, isOn: Bool) {
        print("Switch state changed for element '\(title)': \(isOn)")
    }
}
