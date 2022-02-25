//
//  ViewController.swift
//  Weather app
//
//  Created by Shaxzod Azamatjonov on 23/02/22.
//

import UIKit
import SnapKit
import Lottie

class ViewController: UIViewController {
    var animationView: AnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView = .init(name: "loading")
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 0.7
        view.addSubview(animationView!)
        animationView!.play()
        animationView?.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.height.width.equalTo(300)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
            let vc = UINavigationController(rootViewController: TabBarVC())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false) {
                self.animationView?.stop()
                self.animationView = nil
            }
        }
    }


}

