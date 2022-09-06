//
//  HomeViewController.swift
//  Weather App
//
//  Created by cloud_vfx on 06/09/22.
//

import UIKit
import SnapKit
import CoreLocation

class HomeViewController: UIViewController {
    
    let weatherManager = WeatherManager()
    
    var searchBarText : String = ""
    let searchBar = UISearchBar()
    let tableview = UITableView()
    let locationManager = CLLocationManager()
    
    var resultArr = [City]()
    var fullWeather: WeatherFull?
    
    var isSearching = false
    var isWeekly = true
    var lon: Double = 0.0
    var lat: Double = 0.0
    var cityName: String = "City Name"
    let extrow = 3
    
    let bgColor = UIColor(red: 96/256, green: 96/256, blue: 96/256, alpha: 1)
    
    let defList = [Definition(defText: "Current temprature", iconName: "temp"),
                   Definition(defText: "Feels like temprature", iconName: "feels_like"),
                   Definition(defText: "Atmospheric pressure at the moment", iconName: "pressure"),
                   Definition(defText: "Current air humidity", iconName: "humidity"),
                   Definition(defText: "Wind speed", iconName: "wind"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgColor
        
        initSubviews()
        embedSubviews()
        addSubviewsConstraints()
        configureSearchBar()
        setLocationManager()
    }
}


//  CLLocationManagerDelegate:
extension HomeViewController: CLLocationManagerDelegate {

    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality, placemarks?.first?.country, error)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location: CLLocation = manager.location else { return }
        
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city, error == nil else { return }
            self.cityName = city
        }
        
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(lat: lat, long: lon) { weather in
                self.fullWeather = weather
                
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }
        }
        self.locationManager.stopUpdatingLocation()
    }
    
    func setLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}


//   init Function:
extension HomeViewController {
   
    func configureSearchBar() {
        searchBar.sizeToFit()
        searchBar.endEditing(true)
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        searchBar.placeholder = " write city name"
        searchBar.searchTextField.leftView?.tintColor = .black
        self.searchBar.delegate = self
       
        
        navigationController?.navigationBar.backgroundColor = bgColor
        navigationItem.title = "Open Weather Map"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.barTintColor = bgColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
        showSearchBarButton(shouldShow: true)
    }

    func initSubviews() {
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .clear
        tableview.separatorStyle = .none
        tableview.register(HomeCell.self, forCellReuseIdentifier: "HomeCell")
        tableview.register(InfoCell.self, forCellReuseIdentifier: "InfoCell")
        tableview.register(HourlyCell.self, forCellReuseIdentifier: "HourlyCell")
        tableview.register(WeeklyCell.self, forCellReuseIdentifier: "WeeklyCell")
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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

//  TableViewDelegate:
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            if resultArr.count == 0 {
                return 1
            }
            return resultArr.count
        }
        return  defList.count+extrow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isSearching {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
            if resultArr.count == 0 {
                cell.textLabel?.text = "Search cities..."
                cell.selectionStyle = .none
                return cell
            }
            cell.textLabel?.text = resultArr[indexPath.row].name
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .black
            return cell
        }
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
            cell.backgroundColor = .clear
            cell.initCityName(cityName)
            cell.initDatas(self.fullWeather ?? nil)

            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyCell") as! WeeklyCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyCell") as! HourlyCell

            cell.backgroundColor = .clear
            cell.items = fullWeather?.hourly ?? [Hourly]()
            cell.timezone = fullWeather?.timezone_offset ?? 0
            cell.selectionStyle = .none
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
        cell.backgroundColor = .clear
        cell.initDatas(self.fullWeather ?? nil, index: indexPath.row-extrow)
        cell.initDef(defList[indexPath.row-extrow])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 1 && !isSearching{
            let controller = WeeklyViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            controller.fullWeather = self.fullWeather
            controller.title = cityName
        }
        tableview.reloadData()
    }
}

// UISearchBarDelegate Metods
extension HomeViewController: UISearchBarDelegate {
    
    @objc func handleShowSearchBar () {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
   
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow{
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        isSearching = !isSearching
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarText = searchBar.text!
        // Start fetching data
        getCity(searchText: searchBarText)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.search(shouldShow: false)
            searchBar.text = ""
        }
        tableview.reloadData()
    }

    
    func getCity(searchText: String){
        getWeather(city: searchText) { [self] weather , _  in
            
            DispatchQueue.main.async {
                
                if weather.timezone == "Etc/GMT" {
                    self.cityName = "Unknown!"
                    self.fullWeather = nil
                } else{
                    self.fullWeather = weather
                    self.cityName = searchBarText
                }
                
                tableview.reloadData()
            }
        }
    }
}
