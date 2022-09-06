//
//  DateHeaderView.swift
//  Weather App
//
//  Created by cloud_vfx on 06/09/22.
//

import UIKit

class DateHeaderView: UIView {
    
    let dateFormatter = DateFormatter()
    let customView = UIView()
    let lbl = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lbl)
        lbl.textAlignment = .right
        lbl.backgroundColor = .clear
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        lbl.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
            make.top.equalTo(10)
        }
    }
    
    
    func initData(data: WeatherFull?, sec: Int) {
        dateFormatter.dateFormat = "E,  d. MMM. yyyy"
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: Int(data?.timezone_offset ?? 0))
        dateFormatter.doesRelativeDateFormatting = false
        let date = Date(timeIntervalSince1970: data?.daily[sec].dt ?? 0)
        
        lbl.text = "\( dateFormatter.string(from: date)) y."
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
