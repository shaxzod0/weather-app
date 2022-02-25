//
//  TabBarVC.swift
//  Weather app
//
//  Created by Shaxzod Azamatjonov on 23/02/22.
//

import UIKit

class TabBarVC: UITabBarController {
    let model = CurrentLocationVC()
    override func viewDidLoad(){
        super.viewDidLoad()
        initViews()
    }
}


extension TabBarVC{
    private func initViews(){
        let currentLocation = CurrentLocationVC()
        currentLocation.tabBarItem = UITabBarItem(title: "Current location", image: UIImage(named: "location")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named:"location")?.withRenderingMode(.alwaysOriginal).withTintColor(.purple))
        let searchVC = SearchVC()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), selectedImage:UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(.purple))
        tabBar.backgroundColor = .mainColor
        tabBar.tintColor = .purple
        tabBar.layer.cornerRadius = 10
        tabBar.clipsToBounds = true
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewControllers = [currentLocation,searchVC]
    }
}
