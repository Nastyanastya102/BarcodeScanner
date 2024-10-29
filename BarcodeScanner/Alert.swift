//
//  Alert.swift
//  BarcodeScanner
//
//  Created by Nastya Klyashtorna on 2024-10-28.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidDeviceInputType = AlertItem(
        title: "Invalid barcode",
        message: "The barcode you scanned is not valid.",
        dismissButton: .default(Text("OK"))
    )
    
    static let invalidScanValueType = AlertItem(
        title: "Invalid scan value",
        message: "The barcode you scanned is not valid.",
        dismissButton: .default(Text("OK"))
    )
}
