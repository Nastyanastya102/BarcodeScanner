//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Nastya Klyashtorna on 2024-10-28.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    @Binding var alertItem: AlertItem?
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(scannerView: self)
      return coordinator
    }
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannedDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    final class Coordinator: NSObject, ScannerVCDelagate {
        private var scannerView: ScannerView

        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        func didFindBarcode(_ barcode: String) {
            scannerView.scannedCode = barcode
        }
        
        func didSurfaceError(_ error: CameraError) {
            switch error {
            case .invalidDeviceInput:
                scannerView.alertItem = AlertContext.invalidDeviceInputType
            case .invalidScanValue:
                scannerView.alertItem = AlertContext.invalidScanValueType
            }
            
        }
        
        
    }

}

#Preview {
    ScannerView(scannedCode: .constant(""), alertItem: .constant(nil))
}
