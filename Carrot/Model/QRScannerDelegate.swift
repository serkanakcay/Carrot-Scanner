//
//  QRScannerDelegate.swift
//  Carrot
//
//  Created by serkan on 13.09.2024.
//

import SwiftUI
import AVKit

class QRScannerDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate, ObservableObject {
    @Published var scannedCode: String?

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let code = readableObject.stringValue else { return }
            print(code)
            scannedCode = code
        }
        }
    }

