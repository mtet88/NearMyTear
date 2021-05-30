//
//  LocationPermissionViewController.swift
//  TheRightFit
//
//  Created by Mauricio Torres Mejia on 24.05.21.
//

import UIKit

class LocationPermissionViewController: NMTViewController {
    
    @IBOutlet weak var settingsInfo: UILabel?
    @IBOutlet weak var settingsButton: UIButton?
    
    public var service: LocationService?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.service?.requestPermition()
    }
    
    private func setupView() {
        self.settingsInfo?.isHidden = true
        self.settingsButton?.isHidden = true
    }
    
    func showCardsViewController() {
        
        guard let _cardsViewController = NMTViewController.makeMapViewController() else {
            return
        }

        self.showDetailViewController(_cardsViewController, sender: self)
    }
    
    func showSettingsButtonAndInfo() {
        self.settingsButton?.isHidden = false
        self.settingsInfo?.isHidden = false
    }
}

extension LocationPermissionViewController {
    
    @IBAction func goToSettingsTapped(_sender: Any) {
        
        guard let _settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        UIApplication.shared.open(_settingsURL, options: [:], completionHandler: nil)
    }
}

