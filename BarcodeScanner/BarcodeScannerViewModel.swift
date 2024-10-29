//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by Nastya Klyashtorna on 2024-10-28.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
    
    var statusText: String {
        scannedCode.isEmpty ? "Not yet scanned" : scannedCode
    }
}
