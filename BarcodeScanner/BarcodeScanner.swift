//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Nastya Klyashtorna on 2024-10-27.
//

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
struct BarcodeScanner: View {
    @State private var scannedCode = ""
    @State private var alertItem: AlertItem?

    var body: some View {
        NavigationView {
            VStack {
                ScannerView(scannedCode: $scannedCode, alertItem: $alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                Spacer().frame(height: 50)
                Label("Scanned barcode:", systemImage: "barcode.viewfinder")
                    .font(.title)
                Text(scannedCode.isEmpty ? "Not yet scanned" : scannedCode)
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(scannedCode.isEmpty ? .red : .green)
                    .padding()
            }
            .navigationTitle("BarCode Scanner")
            .alert(item: $alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
//                if case .invalidDeviceInputType = alertItem {
//                    return Alert(title: Text(alertItem.0.0), message: Text(alertItem.0.1), dismissButton: alertItem.0.2)
//                } else if case .invalidScanValueType = alertItem {
//                    let message = "The scanned value is not a valid barcode."
//                    return Alert(title: Text("Invalid barcode"), message: Text(message), dismissButton: .default(Text("OK")))
//                }
            }
        }
    }
}

#Preview {
    BarcodeScanner()
}
