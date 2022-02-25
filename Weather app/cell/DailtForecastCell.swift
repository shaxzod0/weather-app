//
//  DailtForecastCell.swift
//  Weather app
//
//  Created by Shaxzod Azamatjonov on 24/02/22.
//

import UIKit

class DailtForecastCell: UICollectionViewCell {
    let hourText = UILabel()
    let degreeText = UILabel()
    let conditionImage = UIImageView()
    let conditionText = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initViews(){
        self.addSubview(conditionImage)
        self.addSubview(conditionText)
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.backgroundColor = .white.withAlphaComponent(0.7)
        self.addSubview(hourText)
        hourText.text = "12:00"
        hourText.snp.makeConstraints { make in
            make.bottom.equalTo(conditionImage.snp.top)
            make.centerX.equalToSuperview()
        }
        conditionImage.downloaded(from: "http://cdn.weatherapi.com/weather/64x64/night/113.png")
        conditionImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(64)
        }
        self.addSubview(degreeText)
        degreeText.text = "14.0"
        degreeText.font = .systemFont(ofSize: 20, weight: .bold)
        degreeText.textAlignment = .center
        degreeText.snp.makeConstraints { make in
            make.top.equalTo(conditionImage.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        conditionText.text = "Clear"
        conditionText.numberOfLines = 0
        conditionText.snp.makeConstraints { make in
            make.top.equalTo(degreeText.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
    }
    func setItems(item: Hour){
        hourText.text = item.time
        degreeText.text = "\(item.temp_c)°C"
        conditionImage.downloaded(from: item.condition.icon)
        conditionText.text = item.condition.text
    }
}
