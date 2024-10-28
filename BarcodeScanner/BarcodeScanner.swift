//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Nastya Klyashtorna on 2024-10-27.
//

import SwiftUI

struct BarcodeScanner: View {
    var body: some View {
        NavigationView {
            VStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                Spacer().frame(height: 50)
                Label("Scanned barcode:", systemImage: "barcode.viewfinder")
                    .font(.title)
                Text("Not yet scanned")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()
            }
            .navigationTitle("BarCode Scanner")
        }
    }
}

#Preview {
    BarcodeScanner()
}
