//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Nastya Klyashtorna on 2024-10-27.
//

import SwiftUI

struct BarcodeScanner: View {
    @State private var scannedCode = ""
    var body: some View {
        NavigationView {
            VStack {
                ScannerView(scannedCode: $scannedCode)
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
        }
    }
}

#Preview {
    BarcodeScanner()
}
