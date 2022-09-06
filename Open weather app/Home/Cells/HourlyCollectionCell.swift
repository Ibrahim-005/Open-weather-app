//
//  HourlyCollectionCell.swift
//  Weather App
//
//  Created by cloud_vfx on 06/09/22.
//

import UIKit

class HourlyCollectionCell: UICollectionViewCell {    
    
    let timeLbl = UILabel()
    let tempLbl = UILabel()
    let humidityLbl = UILabel()
    let wind_speedLbl = UILabel()
    let defLbl = UILabel()
    let icon = UIImageView()
    
    let color =  UIColor.black
    let mg = 5
    let dateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        contentView.addSubview(timeLbl)
        timeLbl.textAlignment = .center
        timeLbl.textColor = .black
        timeLbl.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        timeLbl.snp.makeConstraints { make in
            make.top.equalTo(mg)
            make.right.left.equalToSuperview()
        }
        
        contentView.addSubview(tempLbl)
        tempLbl.textAlignment = .center
        tempLbl.textColor = .black
        tempLbl.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        tempLbl.snp.makeConstraints { make in
            make.top.equalTo(timeLbl.snp.bottom).offset(2)
            make.right.left.equalToSuperview()
        }

        contentView.addSubview(icon)
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.snp.makeConstraints { make in
            make.top.equalTo(tempLbl.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(50)
        }

        contentView.addSubview(wind_speedLbl)

        wind_speedLbl.textAlignment = .center
        wind_speedLbl.textColor = .black
        wind_speedLbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        wind_speedLbl.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-mg)
        }
     
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initDatas(_ hourly: Hourly?, timezone:Double){
        if hourly?.weather.count != 0 {
            self.icon.image = UIImage(named: hourly?.weather[0].icon ?? "01d")?.withAlignmentRectInsets(UIEdgeInsets(top: -6, left: 8, bottom: -6, right: 8))
           
        }
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: Int(timezone))
        dateFormatter.doesRelativeDateFormatting = false
        let date = Date(timeIntervalSince1970: hourly?.dt ?? 0)
        
        self.timeLbl.text = dateFormatter.string(from: date)
        self.tempLbl.text = String(hourly?.temp ?? 00.00) + "°"
        self.wind_speedLbl.text = String(hourly?.wind_speed ?? 00.00) + "m/s"
    }
    
}
