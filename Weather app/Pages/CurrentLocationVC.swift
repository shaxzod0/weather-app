//
//  CurrentLocationVC.swift
//  Weather app
//
//  Created by Shaxzod Azamatjonov on 23/02/22.
//

import UIKit
import MapKit

class CurrentLocationVC: UIViewController {
    
    weak var collectionView: UICollectionView?
    
    var hourlyData: [Hour] = []
    
    let locationManager = CLLocationManager()
    let getLocation = UIButton()
    let searctTF = UITextField()
    let searchButton = UIButton()
    let background = UIImageView()
    var locationParam = ""
    var weatherInfo: Location?
    var weatherCondition: Current?
    let conditionImage = UIImageView()
    let temperatureText = UILabel()
    let cityName = UILabel()
    let regionName = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        view.addSubview(background)
        background.image = UIImage(named: "background")
        background.contentMode = .scaleAspectFill
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        initViews()
    }
}

extension CurrentLocationVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    
    
    private func initViews(){
        view.addSubview(getLocation)
        view.addSubview(searctTF)
        view.addSubview(searchButton)
        
        
        view.addSubview(conditionImage)
        view.addSubview(temperatureText)
        view.addSubview(cityName)
        view.addSubview(regionName)
        
        conditionImage.snp.makeConstraints { make in
            make.height.width.equalTo(120)
            make.top.equalTo(searctTF.snp.bottom).offset(30)
            make.right.equalToSuperview().inset(20)
        }
        conditionImage.image = UIImage(named: "sun")?.withRenderingMode(.alwaysOriginal).withTintColor(.mainColor)
        
        temperatureText.text = "21°C"
        temperatureText.textColor = .mainColor
        temperatureText.font = .systemFont(ofSize: 80, weight: .bold)
        temperatureText.snp.makeConstraints { make in
            make.top.equalTo(conditionImage.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        cityName.text = "London"
        cityName.font = .systemFont(ofSize: 30, weight: .bold)
        cityName.textColor = .mainColor
        cityName.snp.makeConstraints { make in
            make.top.equalTo(temperatureText.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(20)
        }
        regionName.text = "London"
        regionName.textColor = .mainColor
        regionName.font = .systemFont(ofSize: 20, weight: .heavy)
        regionName.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .horizontal
        l.minimumLineSpacing = 15
        l.minimumInteritemSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: l)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(DailtForecastCell.self, forCellWithReuseIdentifier: "DailtForecastCell")
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(regionName.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        self.collectionView = collectionView
        
        getLocation.setImage(UIImage(named: "location")?.withRenderingMode(.alwaysOriginal).withTintColor(.purple), for: .normal)
        getLocation.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalTo(searctTF.snp.left).inset(-20)
            make.width.height.equalTo(40)
        }
        getLocation.addTarget(self, action: #selector(getLoc), for: .touchUpInside)
        
        searctTF.placeholder = "Search"
        searctTF.layer.borderColor = UIColor.purple.cgColor
        searctTF.layer.cornerRadius = 15
        searctTF.layer.borderWidth = 1
        searctTF.setLeftPaddingPoints(15.0)
        searctTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.purple, for: .normal)
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(searctTF.snp.centerY)
            make.left.equalTo(searctTF.snp.right).inset(-20)
        }
        searchButton.addTarget(self, action: #selector(printCity), for: .touchUpInside)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailtForecastCell", for: indexPath) as! DailtForecastCell
        cell.setItems(item: hourlyData[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    
    
    @objc func printCity(){
        let cityName = searctTF.text
        NetworkManager.shared.getWeatherCurrentLocation(param: cityName ?? "London") { res in
            DispatchQueue.main.async {
                self.weatherInfo = res.location
                self.weatherCondition = res.current
                self.temperatureText.text = "\(res.current.temp_c)°C"
                self.cityName.text = res.location.name
                self.regionName.text = res.location.region
                self.conditionImage.downloaded(from: "http:\(res.current.condition.icon)")
                self.hourlyData = res.forecast.forecastday[0].hour + res.forecast.forecastday[1].hour + res.forecast.forecastday[2].hour
                self.collectionView?.reloadData()
            }
        }
    }
}

extension CurrentLocationVC: CLLocationManagerDelegate{
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            locationParam = "\(lat),\(lon)"
            getWeather(location: locationParam)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func getWeather(location: String){
        NetworkManager.shared.getWeatherCurrentLocation(param: location) { res in
            DispatchQueue.main.async {
                self.weatherInfo = res.location
                self.temperatureText.text = "\(res.current.temp_c)°C"
                self.cityName.text = res.location.name
                self.regionName.text = res.location.region
                self.conditionImage.downloaded(from: "http:\(res.current.condition.icon)")
                self.hourlyData = res.forecast.forecastday[0].hour
                self.collectionView?.reloadData()
            }
        }
    }
    @objc func getLoc(){
        locationManager.startUpdatingLocation()
    }
}
