//
//  DateCell.swift
//  Weather App
//
//  Created by cloud_vfx on 06/09/22.
//

import UIKit

class DateCell: UITableViewCell {

    let view = UIView()
    let topLeftItem = CellItem()
    let bottomLeftItem = CellItem()
    let topRightItem = CellItem()
    let bottomRightItem = CellItem()
    let dateFormatter = DateFormatter()
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
        
        view.addSubview(topLeftItem)
        topLeftItem.snp.makeConstraints { make in
            make.left.top.equalTo(mg)
            make.right.equalTo(view.snp.centerX).offset(-mg/2)
        }
        
        view.addSubview(bottomLeftItem)
        bottomLeftItem.snp.makeConstraints { make in
            make.top.equalTo(topLeftItem.snp.bottom).offset(mg)
            make.left.equalTo(mg)
            make.right.equalTo(view.snp.centerX).offset(-mg/2)
            make.bottom.equalTo(-mg)
        }

        view.addSubview(topRightItem)
        topRightItem.snp.makeConstraints { make in
            make.top.equalTo(topLeftItem.snp.top)
            make.left.equalTo(view.snp.centerX).offset(mg/2)
            make.right.equalTo(-mg)
        }

        view.addSubview(bottomRightItem)
        bottomRightItem.snp.makeConstraints { make in
            make.top.equalTo(bottomLeftItem.snp.top)
            make.left.equalTo(view.snp.centerX).offset(mg/2)
            make.right.equalTo(-mg)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initDatas(_ fullWeather: WeatherFull?, section: Int, index: Int){
        if index == 1 {
            self.topLeftItem.valLbl.text = String(fullWeather?.daily[section].temp?.morn ?? 0) + " ℃"
            self.bottomLeftItem.valLbl.text = String(fullWeather?.daily[section].temp?.eve ?? 0) + " ℃"
            self.topRightItem.valLbl.text = String(fullWeather?.daily[section].temp?.day ?? 0) + " ℃"
            self.bottomRightItem.valLbl.text = String(fullWeather?.daily[section].temp?.night ?? 0) + " ℃"
        }
        if index == 2 {
            dateFormatter.dateFormat = "h:mm a"
            dateFormatter.timeZone = TimeZone.init(secondsFromGMT: Int(fullWeather?.timezone_offset ?? 0))
            dateFormatter.doesRelativeDateFormatting = false
            var date = Date(timeIntervalSince1970: fullWeather?.daily[section].sunrise ?? 0)
            self.topLeftItem.valLbl.text = String(dateFormatter.string(from: date))
            date = Date(timeIntervalSince1970: fullWeather?.daily[section].moonrise ?? 0)
            self.bottomLeftItem.valLbl.text =  String(dateFormatter.string(from: date))
            date = Date(timeIntervalSince1970: fullWeather?.daily[section].sunset ?? 0)
            self.topRightItem.valLbl.text =  String(dateFormatter.string(from: date))
            date = Date(timeIntervalSince1970: fullWeather?.daily[section].moonset ?? 0)
            self.bottomRightItem.valLbl.text =  String(dateFormatter.string(from: date))
        }
        if index == 3 {
            self.topLeftItem.valLbl.text = String(fullWeather?.daily[section].humidity ?? 0) + " % "
            self.topRightItem.valLbl.text = String(fullWeather?.daily[section].pressure ?? 0) + " mbar"
            self.bottomLeftItem.valLbl.text = String(fullWeather?.daily[section].wind_speed ?? 0) + " m/s"
            self.bottomRightItem.valLbl.text = String(fullWeather?.daily[section].clouds ?? 0) + " % "
        }
    }

    func initDef(_ def: [String: String]){
        self.topLeftItem.defLbl.text = def["def1"]
        self.topRightItem.defLbl.text = def["def2"]
        self.bottomLeftItem.defLbl.text = def["def3"]
        self.bottomRightItem.defLbl.text = def["def4"]
    }
}


class CellItem: UIView {
    
    let defLbl = UILabel()
    let valLbl = UILabel()
    let mg = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(defLbl)
        defLbl.backgroundColor = .clear
        defLbl.textAlignment = .center
        defLbl.textColor = .black
        defLbl.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        defLbl.snp.makeConstraints { make in
            make.top.equalTo(mg)
            make.centerX.equalToSuperview()
        }
        
        addSubview(valLbl)
        valLbl.backgroundColor = .clear
        valLbl.textAlignment = .center
        valLbl.textColor = .black
        valLbl.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        valLbl.snp.makeConstraints { make in
            make.top.equalTo(defLbl.snp.bottom).offset(mg)
            make.centerX.equalTo(defLbl.snp.centerX)
            make.bottom.equalTo(-10)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
