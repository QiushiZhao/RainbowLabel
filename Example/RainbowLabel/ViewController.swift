//
//  ViewController.swift
//  RainbowLabel
//
//  Created by Jerry on 03/24/2023.
//  Copyright (c) 2023 Jerry. All rights reserved.
//

import UIKit
import RainbowLabel

class ViewController: UIViewController {

  private lazy var label: RainbowLabel = {
    let label = RainbowLabel()
    label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
    label.text = "Hello Rainbow"
    label.startPoint = CGPoint(x: 0, y: 0)
    label.endPoint = CGPoint(x: 1, y: 0)
    label.colors = [UIColor(red: 0.22, green: 1.0, blue: 0.7, alpha: 1.0).cgColor,
                    UIColor(red: 1.0, green: 0.8, blue: 0.3, alpha: 1.0).cgColor,
                    UIColor(red: 1.0, green: 0.61, blue: 0.05, alpha: 1.0).cgColor]
    label.locations = [0, 0.58, 1]
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(label)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    label.sizeToFit()
    label.center = view.center
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

