//
//  WeeklyViewController.swift
//  Weather App
//
//  Created by cloud_vfx on 06/09/22.
//

import UIKit

class WeeklyViewController: UIViewController {
    
    let tableview = UITableView()
    
    var refreshControl: UIRefreshControl!
    var fullWeather: WeatherFull?
    
    let bgColor = UIColor(red: 96/256, green: 96/256, blue: 96/256, alpha: 1)
    let extrow = 2
    
    let defList = [
        ["def1":"like daily temperature","def2":"like night temperature"],
        ["def1":"morning temperature","def2":"evening temperature", "def3":"daily temperature", "def4":"night temperature" ],
        ["def1":"sunrise","def2":"sunset", "def3":"moonrise", "def4":"moonset" ],
        ["def1":"humidity","def2":"pressure", "def3":"wind_speed", "def4":"clouds" ],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgColor
        
        initSubviews()
        embedSubviews()
        addSubviewsConstraints()
        configureSearchBar()
    }
    
    @objc func refresh(_ sender: Any) {
        refreshControl.endRefreshing()
    }
    
    func configureSearchBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.backgroundColor = bgColor
        navigationItem.title = self.title //"Weekly weather forecast"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.barTintColor = bgColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
    }

    func initSubviews() {
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "loading...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableview.addSubview(refreshControl)
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .clear
        tableview.separatorStyle = .none
        tableview.register(DateCell.self, forCellReuseIdentifier: "DateCell")
        tableview.register(MainCell.self, forCellReuseIdentifier: "MainCell")
    }
    
    func embedSubviews() {
        view.addSubview(tableview)
    }
    
    func addSubviewsConstraints() {
        tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension WeeklyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fullWeather?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customView = DateHeaderView()
        customView.initData(data: fullWeather, sec: section)
        customView.backgroundColor = bgColor
        return customView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  defList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! MainCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.initDatas(fullWeather, section: indexPath.section)
            cell.initDef(defList[indexPath.row])
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell") as! DateCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.initDatas(fullWeather, section: indexPath.section, index: indexPath.row)
        cell.initDef(defList[indexPath.row])
        return cell
    }
}
