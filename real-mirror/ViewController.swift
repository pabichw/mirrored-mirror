//
//  ViewController.swift
//  real-mirror
//
//  Created by Wiktor Pabich on 31/10/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    private let captureSession = AVCaptureSession()
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview = AVCaptureVideoPreviewLayer(session: self.captureSession)
        preview.videoGravity = .resizeAspectFill
        return preview
    }()
    
    private func addPreviewLayer() {
        self.view.layer.addSublayer(self.previewLayer)
    }
    
    private func addCameraInput() {
        let device = AVCaptureDevice.default(.builtInTrueDepthCamera, for: .video, position: .front)!
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        self.captureSession.addInput(cameraInput)
    }
    
    private func showNoSupportAlert() {
        let alert = UIAlertController(
            title: "Opps!",
            message: "Your device doesn't support image fliping, which is unusual. This app will likely crash in a second. Do NOT reach out to the developer - he doesn't care really.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Umm, OK...?", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addCameraInput()
        self.addPreviewLayer()
        self.captureSession.startRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewLayer.frame = self.view.bounds
        
        if (self.previewLayer.connection!.isVideoMirroringSupported) {
            self.previewLayer.connection!.automaticallyAdjustsVideoMirroring = false
            self.previewLayer.connection!.isVideoMirrored = false
        } else {
            self.showNoSupportAlert()
        }
        
    }

}

