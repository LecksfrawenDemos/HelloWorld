//
//  ViewController.swift
//  CarSensor
//
//  Created by Hector de Diego on 2/19/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var changeTitleButton: UIButton!
  
  var page: Int?
  
  fileprivate func updatePageNumber() {
    if let unwrappedPage = page {
      titleLabel.text = "Título de página \(unwrappedPage)"
      subtitleLabel.text = "Subtítulo de página \(unwrappedPage)"
    }
  }
  
  fileprivate func updateButtonNumber() {
    changeTitleButton.setTitle(
      "Cambia a página \(page! + 1)",
      for: .normal
    )
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    print("Hola mundo")
    page = 12
    updatePageNumber()
    updateButtonNumber()
    
  }
  
  @IBAction func changeTitleAction(_ sender: UIButton) {
    /// Quiero que se muestre un nuevo número de página
    if page != nil {
      page = page! + 1
      updatePageNumber()
    }
    updateButtonNumber()
  }
}

