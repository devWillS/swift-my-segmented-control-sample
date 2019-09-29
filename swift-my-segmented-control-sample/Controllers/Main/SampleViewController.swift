//
//  ViewController.swift
//  swift-my-segmented-control-sample
//
//  Created by devWill on 2018/07/04.
//  Copyright © 2018年 devWill. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {
    @IBOutlet weak var segmentedCotrolFirst: MySegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button1 = MySegmentedControl.DataSource(title: "1", isNonRegistered: false)
        let button2 = MySegmentedControl.DataSource(title: "2", isNonRegistered: false)
        let button3 = MySegmentedControl.DataSource(title: "3", isNonRegistered: true)
        let button4 = MySegmentedControl.DataSource(title: "4", isNonRegistered: true)
        segmentedCotrolFirst.dataSource = [button1, button2, button3, button4]
        
        segmentedCotrolFirst.delegate = self
    }
}

extension SampleViewController: MySegmentControlDelegate {
    func tapped(index: Int) {
        print(index)
    }
}
