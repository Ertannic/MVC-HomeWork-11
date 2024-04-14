//
//  CustomSwitchDelegate.swift
//  MVC HomeWork
//
//  Created by Ertannic Saralay on 14.04.2024.
//
import UIKit
import SnapKit

protocol CustomSwitchDelegate: AnyObject {
    func doNotDisturbSwitchChanged(isOn: Bool)
}

class DoNotDisturbViewController: UIViewController {
        
    var iconName: String = "hand.tap.fill"
    var iconColor: UIColor = .green
    var isSwitchOn: Bool = false
    
    let iconImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView

    }()
    
    let switchView: UISwitch = {
        
        let switchView = UISwitch()
        return switchView
        
    }()
    
    weak var delegate: CustomSwitchDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(iconImageView)
        iconImageView.image = UIImage(systemName: iconName)
        iconImageView.tintColor = iconColor
        
        view.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { make in
            
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.height.equalTo(200)
            
        }
        
        view.addSubview(switchView)
        switchView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(40)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        switchView.isOn = isSwitchOn
        
        switchView.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
            isSwitchOn = sender.isOn
            updateUI()
        
        delegate?.doNotDisturbSwitchChanged(isOn: isSwitchOn)
        }
    
    private func updateUI() {
            
            iconName = isSwitchOn ? "sun.max.circle.fill" : "moon.circle.fill"
            iconColor = isSwitchOn ? .yellow : .systemPurple

            iconImageView.image = UIImage(systemName: iconName)
            iconImageView.tintColor = iconColor

            
            view.backgroundColor = isSwitchOn ? .white : .darkGray
        }
    
}
