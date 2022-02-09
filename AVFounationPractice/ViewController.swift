//
//  ViewController.swift
//  AVFounationPractice
//
//  Created by 竣亦 on 2022/2/9.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var forPreview: UIView!
    
    let session = AVCaptureSession()
    let deviceInput = DeviceInput()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settingPreviewLayer()
        session.addInput(deviceInput.backWildAngleCamera!)
        session.startRunning()
    }
    
    func settingPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer()
        previewLayer.frame = forPreview.bounds
        previewLayer.session = session
        previewLayer.videoGravity = .resizeAspectFill
        forPreview.layer.addSublayer(previewLayer)
    }

    @IBAction func frontBackToggle(_ sender: UISwitch) {
        session.beginConfiguration()
        
        session.removeInput(session.inputs.last!)
        
        if sender.isOn {
            session.addInput(deviceInput.backWildAngleCamera!)
        } else {
            session.addInput(deviceInput.frontWildAngleCamera!)
        }
        
        session.commitConfiguration()
        
    }
    
}

