//
//  File.swift
//  AVFounationPractice
//
//  Created by 竣亦 on 2022/2/9.
//

import Foundation
import AVFoundation

class DeviceInput: NSObject {
    
    var frontWildAngleCamera: AVCaptureDeviceInput?
    var backWildAngleCamera: AVCaptureDeviceInput?
    var backTelephotoCamera: AVCaptureDeviceInput?
    var backDualCamera: AVCaptureDeviceInput?
    
    
    func getAllCameras() {
        let cameraDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera, .builtInDualCamera], mediaType: .video, position: .unspecified).devices
        
        for camera in cameraDevices {
            let inputDevice = try! AVCaptureDeviceInput(device: camera)
            
            if camera.deviceType == .builtInWideAngleCamera, camera.position == .front {
                frontWildAngleCamera = inputDevice
            }
            
            if camera.deviceType == .builtInWideAngleCamera, camera.position == .back {
                backWildAngleCamera = inputDevice
            }
            
            if camera.deviceType == .builtInDualCamera {
                backDualCamera = inputDevice
            }
            
            if camera.deviceType == .builtInTelephotoCamera {
                backTelephotoCamera = inputDevice
            }
        }
    }
    
    override init() {
        super.init()
        getAllCameras()
    }
    
}
