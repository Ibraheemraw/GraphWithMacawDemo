//
//  HomeController.swift
//  GraphWithMacawDemo
//
//  Created by Ibraheem rawlinson on 3/23/20.
//  Copyright © 2020 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet weak var macawChartView: MacawChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        macawChartView.contentMode = .scaleAspectFit
    }
    

    
    @IBAction func ShowChart(_ sender: UIButton) {
        MacawChartView.playAnimations()
    }
    
}
