//
//  ViewController.swift
//  project-goethe
//
//  Created by Andimas Bagaswara on 08/06/20.
//  Copyright © 2020 Andimas Bagaswara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "hasLaunched")
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "hasLaunched")
            let launchStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = launchStoryboard.instantiateViewController(identifier: "OnboardingStoryboard")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
}

