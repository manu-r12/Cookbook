//
//  IngredientsFInderViewController.swift
//  CookBook
//
//  Created by Manu on 2024-04-20.
//

import UIKit
import AVKit
import SwiftUI
import Vision

class IngredientsFinderWithCameraViewController: 
    UIViewController,
    AVCaptureVideoDataOutputSampleBufferDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTheCamera()
        configureCancelBtn()
        view.backgroundColor = .black
        
    }
    
    
    private func configureTheCamera(){
        let avCaptureSession = AVCaptureSession()
        
        guard let avCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("Error in loading the video camera")
            return
        }
        guard let input = try? AVCaptureDeviceInput(device: avCaptureDevice) else {return}
        avCaptureSession.addInput(input)
        
        avCaptureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
         previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQuue"))
        avCaptureSession.addOutput(dataOutput)
        
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixleBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            print("Could'nt get CVPixelBuffer from CMSampleBufferGetImageBuffer(sampleBuffer)")
            return
        }
    }
    
    
    private func configureCancelBtn(){
        
        let cancelButton = UIButton(type: .system)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        view.addSubview(cancelButton)

        // Position cancel button
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
  
    
    @objc func cancelButtonTapped() {
          // Handle cancel button tap action
          dismiss(animated: true, completion: nil)
      }
    
    
    
}

struct UIKitViewControllerWrapper<Content: UIViewController>: UIViewControllerRepresentable {
    let viewController: Content
    
    func makeUIViewController(context: Context) -> Content {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: Content, context: Context) {
        // (Optional) Update the view controller if needed
    }
}
