//
//  ContentView.swift
//  Carrot
//
//  Created by serkan on 11.09.2024.
//

import SwiftUI

struct ContentView: View {
   
    var body: some View {
        switch vm.dataScannerAccesStatus{
        case .scannerAvailable:
            Text("Scanner is available")
        case .cameraNotAvailable:
            Text("Your Device doesn't have a camera")
            
        case .scannerNotAvailable:
            Text("Your device doesn't have support for scanning barcode with this app")
            
        case .cameraAcessNotGranted:
            Text("Please provide acces to the came in setting")
            
        case .notDermined:
            Text("Requesting camera access")
        }
        
    }
}

#Preview {
    ContentView()
}
