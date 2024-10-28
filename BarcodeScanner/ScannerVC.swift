//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by Nastya Klyashtorna on 2024-10-27.
//

import Foundation
import AVFoundation
import UIKit

protocol ScannerVCDelagate: AnyObject {
    func didFindBarcode(_ barcode: String)
    
}

final class ScannerVC: UIViewController {
    let captureSesion = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannedDelegate: ScannerVCDelagate?
    
    init(scannedDelegate: ScannerVCDelagate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.scannedDelegate = scannedDelegate
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func captureSessionSetup() {
        guard let videoDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput = try? AVCaptureDeviceInput(device: videoDevice)
        captureSesion.addInput(videoInput!)
        
        let videoOutput = AVCaptureMetadataOutput()
        
        if captureSesion.canAddOutput(videoOutput) {
            captureSesion.addOutput(videoOutput)
            videoOutput.metadataObjectTypes = [.ean8, .ean13, .qr]
        } else {
            return
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSesion)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSesion.startRunning()
    }

}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else { return }
        guard let stringValue = metadataObject.stringValue else { return }
        
        scannedDelegate?.didFindBarcode(stringValue)
    }
}
