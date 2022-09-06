//
//  weeklyCell.swift
//  Weather App
//
//  Created by cloud_vfx on 06/09/22.
//

import UIKit
import SnapKit

class WeeklyCell: UITableViewCell {
    
    let label = UILabel()
    let icon = UIImageView()
    let color = UIColor.black.withAlphaComponent(50)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        self.selectionStyle = .none
        
        addSubview(icon)
        icon.image = UIImage(named: "right-arrow")?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = color
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.width.equalTo(20)
        }
        
        addSubview(label)
        label.text = "Weekly weather forecast"
        label.textAlignment = .right
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(icon.snp.left).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
