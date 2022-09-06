//
//  HourlyCell.swift
//  Weather App
//
//  Created by cloud_vfx on 06/09/22.
//

import UIKit

class HourlyCell: UITableViewCell {
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HourlyCollectionCell.self, forCellWithReuseIdentifier: "HourlyCollectionCell")
        collectionView.layer.cornerRadius = 10
        return collectionView
    }()
    
    var timezone:Double = 0
    var items = [Hourly](){
        didSet{
            collectionView.reloadData()
            collectionView.setContentOffset(CGPoint(x:0,y:0), animated: false)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .clear

        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(120)
            make.bottom.equalTo(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HourlyCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCollectionCell", for: indexPath) as! HourlyCollectionCell
        cell.backgroundColor = .clear 
        cell.layer.cornerRadius = 8
        
        cell.initDatas(items[indexPath.row],timezone: timezone)
        if indexPath.row == 0{
            cell.timeLbl.text = "present"
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 120)
    }
}












