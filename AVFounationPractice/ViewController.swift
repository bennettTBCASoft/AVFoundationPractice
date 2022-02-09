//
//  ViewController.swift
//  AVFounationPractice
//
//  Created by 竣亦 on 2022/2/9.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    //預覽鏡頭資料
    @IBOutlet weak var forPreview: UIView!
    
    // 負責處理輸入裝置->輸出間的資料流動
    let session = AVCaptureSession()
    // 負責設定好輸入端擷取裝置
    let deviceInput = DeviceInput()
    
    //顯示條碼內容與種類
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //設定預覽圖層 - 此為自訂函數
        settingPreviewLayer()
        
        //將後置廣角鏡頭連接到協調器
        session.addInput(deviceInput.backWildAngleCamera!)
        
        //設定輸出端為meta資料(e.g., 條碼內容）
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        //接受所有可辨識的meta資料
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.global())
        
        
        
        //讓資料開始流入
        session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadataObject in metadataObjects {
            if let data =  metadataObject as? AVMetadataMachineReadableCodeObject {
                DispatchQueue.main.async {
                    self.codeLabel.text = data.stringValue
                    self.typeLabel.text = data.type.rawValue
                }
            }
        }
    }
    
    func settingPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer()
        previewLayer.frame = forPreview.bounds
        previewLayer.session = session
        previewLayer.videoGravity = .resizeAspectFill
        forPreview.layer.addSublayer(previewLayer)
    }

    @IBAction func frontBackToggle(_ sender: UISwitch) {
        // 修改 session 開始
        session.beginConfiguration()
        
        // 將現有的 input 刪除
        session.removeInput(session.inputs.last!)
        
        if sender.isOn {
            // 後置鏡頭
            session.addInput(deviceInput.backWildAngleCamera!)
        } else {
            // 前置鏡頭
            session.addInput(deviceInput.frontWildAngleCamera!)
        }
        
        //確認修改
        session.commitConfiguration()
        
    }
    
}

