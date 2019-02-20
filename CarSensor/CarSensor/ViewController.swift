//
//  ViewController.swift
//  CarSensor
//
//  Created by Hector de Diego on 2/19/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
  
  @IBOutlet weak var activateButton: UIButton!
  
  @IBOutlet weak var initialXLabel: UILabel!
  @IBOutlet weak var initialYLabel: UILabel!
  @IBOutlet weak var initialZLabel: UILabel!
  
  @IBOutlet weak var xLabel: UILabel!
  @IBOutlet weak var yLabel: UILabel!
  @IBOutlet weak var zLabel: UILabel!
  
  @IBOutlet weak var statusLabel: UILabel!
  
  var referenceAttitude: CMAttitude?
  
  var pitch: Double = 0.0 // X
  var roll: Double = 0.0 // Y
  var yaw: Double = 0.0 // Z
  
  var isButtonSelected: Bool = false
  var motion: CMMotionManager = CMMotionManager()
  
  lazy var queue: OperationQueue = {
    var queue = OperationQueue()
    queue.name = "Motion Queue"
    queue.maxConcurrentOperationCount = 1
    return queue
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    activateButton.setTitle("Activado", for: .selected)
    activateButton.setTitle("Activar", for: .normal)
    updateCurrentValues()
  }
  
  @IBAction func getDefaultValuesAction(_ sender: UIButton) {
    if motion.isDeviceMotionAvailable {
      motion.startDeviceMotionUpdates(to: queue) {
        [weak self] (data, error) in
        
        // Make sure the data is valid before accessing it.
        if let validData = data {
          // Get the attitude relative to the magnetic north reference frame.
          self?.referenceAttitude = validData.attitude
          self?.motion.stopDeviceMotionUpdates()
          DispatchQueue.main.async {
            self?.initialXLabel.text = "X: \(String(format:"%.4f", self?.referenceAttitude?.pitch ?? 0.0))"
            self?.initialYLabel.text = "Y: \(String(format:"%.4f", self?.referenceAttitude?.roll ?? 0.0))"
            self?.initialZLabel.text = "Z: \(String(format:"%.4f", self?.referenceAttitude?.yaw ?? 0.0))"
          }
        }
      }
    }
  }
  
  @IBAction func switchDetectionAction(_ sender: UIButton) {
    isButtonSelected = !isButtonSelected
    sender.isSelected = isButtonSelected
    if isButtonSelected {
      startQueuedUpdates()
    } else {
      motion.stopDeviceMotionUpdates()
    }
  }
  
  private func updateCurrentValues() {
    xLabel.text = "X: \(String(format: "%.4f", pitch))"
    yLabel.text = "Y: \(String(format: "%.4f", roll))"
    zLabel.text = "Z: \(String(format: "%.4f", yaw))"
  }
  
  fileprivate func checkCurrentPitch() {
    
    let curentPitch = self.pitch
    if let originalPitch = self.referenceAttitude?.pitch {
      let currentPitchIsHigher = curentPitch > originalPitch
      let currentPitchIsLower = curentPitch < originalPitch
      let hasMoved = currentPitchIsHigher || currentPitchIsLower
      DispatchQueue.main.async {
        self.statusLabel.text = "Has moved: \(hasMoved ? "YES" : "NO")"
      }
    }
  }
  
  fileprivate func printValues() {
    // Cuando lo sacudes
    
    // Use the motion data in your app.
    print("pitch: \(String(format:"%.4f", self.pitch))")
    print("roll: \(String(format:"%.4f", self.roll))")
    print("yaw: \(String(format:"%.4f", self.yaw))")
  }
  
  func startQueuedUpdates() {
    if motion.isDeviceMotionAvailable {
      self.motion.deviceMotionUpdateInterval = 1.0
      self.motion.showsDeviceMovementDisplay = true
      self.motion.startDeviceMotionUpdates(to: queue) {
        [weak self] (data, error) in
        // Make sure the data is valid before accessing it.
        if let validData = data {
          // Get the attitude relative to the magnetic north reference frame.
          self?.pitch = validData.attitude.pitch // Cuando lo mueves la pantalla hacia ti o al revez
          self?.roll = validData.attitude.roll // Cuando lo giras
          self?.yaw = validData.attitude.yaw
          self?.printValues()
          DispatchQueue.main.async {
            self?.updateCurrentValues()
          }
          self?.checkCurrentPitch()
        }
      }
    }
  }
}

