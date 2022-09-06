//
//  InfoCell.swift
//  Weather App
//
//  Created by cloud_vfx on 06/09/22.
//

import UIKit

class InfoCell: UITableViewCell {
    
    let view = UIView()
    let defLbl = UILabel()
    let valLbl = UILabel()
    let icon = UIImageView()
    
    let color =  UIColor.black
    let mg = 20
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        
        contentView.addSubview(view)
        
        view.addSubview(icon)
        view.addSubview(defLbl)
        view.addSubview(valLbl)
        
        view.backgroundColor = .white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        view.snp.makeConstraints { make in
            make.left.top.equalTo(10)
            make.right.bottom.equalTo(-10)
        }
        
        valLbl.backgroundColor = .clear
        valLbl.textAlignment = .right
        valLbl.textColor = color
        valLbl.tag = 2
        valLbl.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        valLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-mg)
        }
        
        
        icon.backgroundColor = .clear
        icon.tintColor = color
        icon.snp.makeConstraints { make in
            make.top.equalTo(mg)
            make.right.equalTo(valLbl.snp.left).offset(-10)
            make.height.width.equalTo(20)
            make.bottom.equalTo(-mg)
        }
       
        defLbl.backgroundColor = .clear
        defLbl.textAlignment = .left
        defLbl.textColor = color
        defLbl.numberOfLines = 2
        defLbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        defLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(mg)
            make.right.lessThanOrEqualTo(icon.snp.left).offset(-10)
        }
        
        valLbl.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        defLbl.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initDatas(_ fullWeather: WeatherFull?, index: Int){
        if index == 0 {
            self.valLbl.text = String(fullWeather?.current.temp ?? 0.0) + " ℃"
        }
        if index == 1 {
            self.valLbl.text = String(fullWeather?.current.feels_like ?? 0.0) + " ℃"
        }
        if index == 2 {
            self.valLbl.text = String(fullWeather?.current.pressure ?? 0) + " mB"
        }
        if index == 3 {
            self.valLbl.text = String(fullWeather?.current.humidity ?? 0) + " %"
        }
        if index == 4 {
            self.valLbl.text = String(fullWeather?.current.wind_speed ?? 0) + " m/s"
        }
    }

    func initDef(_ def: Definition?){
        self.defLbl.text = def?.defText
        self.icon.image = UIImage(named: def?.iconName ?? "")?.withRenderingMode(.alwaysTemplate)
    }
}
