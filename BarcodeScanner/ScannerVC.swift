//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by Nastya Klyashtorna on 2024-10-27.
//

import Foundation
import AVFoundation
import UIKit

enum CameraError: String {
    case invalidDeviceInput = "Invalid device input"
    case invalidScanValue = "Invalid scan value. This app scanns only barcodes EAN13 and EAN8"
}

protocol ScannerVCDelagate: AnyObject {
    func didFindBarcode(_ barcode: String)
    func didSurfaceError(_ error: CameraError)
    
}

final class ScannerVC: UIViewController {
    let captureSesion = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannedDelegate: ScannerVCDelagate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSessionSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else {
            scannedDelegate?.didSurfaceError(.invalidDeviceInput)
            return
        }
        previewLayer.frame = view.layer.bounds
    }
    
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
            scannedDelegate?.didSurfaceError(.invalidDeviceInput)
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
        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else {
            scannedDelegate?.didSurfaceError(.invalidScanValue)
            return
        }
        guard let stringValue = metadataObject.stringValue else {
            scannedDelegate?.didSurfaceError(.invalidScanValue)
            return
        }
        
        scannedDelegate?.didFindBarcode(stringValue)
    }
}
