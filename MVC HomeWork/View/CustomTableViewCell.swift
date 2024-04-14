//
//  CustomTableViewCell.swift
//  MVC HomeWork
//
//  Created by Ertannic Saralay on 14.04.2024.
//
import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    let customImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.tintColor = .black // Начальный цвет изображения
            return imageView
        }()
    
    let switchView: UISwitch = {
            let switchView = UISwitch()
            switchView.isHidden = true
            return switchView
        }()
    
    let customDetailTextLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()
        
        var switchChanged: ((Bool) -> Void)?


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           
           // Добавляем UIImageView к ячейке
        contentView.addSubview(customImageView)
        contentView.addSubview(switchView)
           
           // Устанавливаем constraints для изображения
        customImageView.snp.makeConstraints { make in
               make.centerY.equalToSuperview()
               make.leading.equalToSuperview().offset(16)
               make.width.height.equalTo(30) // Устанавливаем размер изображения
           }
        
        // Настраиваем порядок отображения текста и изображения
        textLabel?.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(customImageView.snp.trailing).offset(16)
            }
        
        contentView.addSubview(customDetailTextLabel)
                customDetailTextLabel.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.trailing.equalToSuperview().offset(-16)
                }
        
        switchView.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.trailing.equalToSuperview().offset(-16)
                }
                
        switchView.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            
       }

    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            switchView.frame.origin.y = (frame.height - switchView.frame.height) / 2
        }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
            switchChanged?(sender.isOn)
        }
        
    func showSwitch(_ show: Bool) {
            switchView.isHidden = !show
        }
   }
