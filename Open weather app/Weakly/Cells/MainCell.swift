//
//  MainCell.swift
//  Weather App
//
//  Created by cloud_vfx on 06/09/22.
//

import UIKit

class MainCell: UITableViewCell {

    let view = UIView()
    let leftItem = mainItem()
    let topRightItem = CellItem()
    let bottomRightItem = CellItem()
    let color =  UIColor.black
    let mg = 20
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        
        contentView.addSubview(view)
        view.backgroundColor = .white.withAlphaComponent(0.3)
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        view.snp.makeConstraints { make in
            make.left.top.equalTo(10)
            make.right.bottom.equalTo(-10)
        }
        
        view.addSubview(leftItem)
        view.addSubview(topRightItem)
        view.addSubview(bottomRightItem)
        
        leftItem.snp.makeConstraints { make in
            make.left.equalTo(mg)
            make.top.equalTo(mg)
            make.bottom.equalTo(-mg)
            make.right.equalTo(view.snp.centerX).offset(-mg/2)
        }
        topRightItem.snp.makeConstraints { make in
            make.top.equalTo(mg)
            make.left.equalTo(view.snp.centerX).offset(mg/2)
            make.right.equalTo(-mg)
        }
        bottomRightItem.snp.makeConstraints { make in
            make.top.equalTo(topRightItem.snp.bottom).offset(mg)
            make.left.equalTo(view.snp.centerX).offset(mg/2)
            make.right.equalTo(-mg)
            make.bottom.equalTo(-mg)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initDatas(_ fullWeather: WeatherFull?, section: Int){
        self.leftItem.icon.image = UIImage(named: fullWeather?.daily[section].weather[0].icon ?? "01d")
        self.leftItem.valLbl.text = fullWeather?.daily[section].weather[0].description ?? ""
        self.topRightItem.valLbl.text = String(fullWeather?.daily[section].feels_like?.day ?? 0) + " ℃"
        self.bottomRightItem.valLbl.text = String(fullWeather?.daily[section].feels_like?.night ?? 0) + " ℃"
    }

    func initDef(_ def: [String: String]){
        self.topRightItem.defLbl.text = def["def1"]
        self.bottomRightItem.defLbl.text = def["def2"]
    }
}


class mainItem: UIView {
    
    let icon = UIImageView()
    let valLbl = UILabel()
    let mg = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(icon.snp.height)
        }
        
        addSubview(valLbl)
        valLbl.backgroundColor = .clear
        valLbl.textAlignment = .center
        valLbl.textColor = .black
        valLbl.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        valLbl.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-mg)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
