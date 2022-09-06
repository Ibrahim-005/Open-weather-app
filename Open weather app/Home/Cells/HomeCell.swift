//
//  HomeCell.swift
//  Weather App
//
//  Created by cloud_vfx on 06/09/22.
//

import UIKit
import SnapKit

class HomeCell: UITableViewCell {
    
    let locationLbl = UILabel()
    let icon = UIImageView()
    let statusLbl = UILabel()
    let temperatureLbl = UILabel()
    let margin = UIScreen.main.bounds.size.height/15
    let mgY = UIScreen.main.bounds.size.height/20
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        
        contentView.addSubview(locationLbl)
        locationLbl.backgroundColor = .clear
        locationLbl.textAlignment = .center
        locationLbl.textColor = .white.withAlphaComponent(0.7)
        locationLbl.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.regular)
        locationLbl.snp.makeConstraints { make in
            make.top.equalTo(margin)
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(icon)
        icon.backgroundColor = .clear
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        
        icon.snp.makeConstraints { make in
            make.top.equalTo(locationLbl.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        contentView.addSubview(statusLbl)
        statusLbl.backgroundColor = .clear
        statusLbl.textAlignment = .center
        statusLbl.textColor = .white
        statusLbl.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.light)
        statusLbl.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(temperatureLbl)
        temperatureLbl.backgroundColor = .clear
        temperatureLbl.textAlignment = .center
        temperatureLbl.textColor = .black
        temperatureLbl.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.bold)
        temperatureLbl.snp.makeConstraints { make in
            make.top.equalTo(statusLbl.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCityName(_ city: String) {
        self.locationLbl.text = city
    }
    
    func initDatas(_ fullWeather: WeatherFull?){
        if fullWeather?.current.weather.count != 0 {
            self.icon.image = UIImage(named: fullWeather?.current.weather[0].icon ?? "")?.withAlignmentRectInsets(UIEdgeInsets(top: -12, left: 15, bottom: -12, right: 15))
            self.statusLbl.text = fullWeather?.current.weather[0].main ?? "Clear"
        }
        self.temperatureLbl.text = String(fullWeather?.current.temp ?? 0.0) + " ℃"
    }

}
