//
//  ViewController.swift
//  onboarding-holiday-app
//
//  Created by sherry on 22/05/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var GetStartedButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // 2 func for lifecycle of view controllers
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //for hiding nav bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func getStartedButtonTapped(_ sender: Any) {
    }
    
}

