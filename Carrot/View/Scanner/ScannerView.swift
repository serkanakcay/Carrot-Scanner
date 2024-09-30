// File: Views/ScannerView.swift
import SwiftUI
import AVKit

struct ScannerView: View {
    // QR code Scanner Properties
    @State private var isScanning: Bool = false
    @State var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    // QR Scanner AV Output
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    // Error properties
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @Environment(\.openURL) private var openURL
    // Camera QR Output Delegate
    @StateObject private var qrDelegate = QRScannerDelegate()
    @State private var scannedCode: String?
    @State private var showProductView: Bool = false  // Sheet'i göstermek için

    var body: some View {
        VStack(spacing: 8) {
            Button(action: {}, label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.blue)
            })
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("Place the Barcode inside the area")
                .font(.title3)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 20)

            Text("Scanning will start automatically")
                .font(.callout)
                .foregroundColor(.gray)
            Spacer(minLength: 0)

            // Scanner
            GeometryReader { geo in
                let size = geo.size
                ZStack {
                    CameraView(frameSize: CGSize(width: size.width, height: size.width), session: $session)
                        .scaleEffect(0.97)

                    ForEach(0...4, id: \.self) { index in
                        let rotation = Double(index) * 90
                        RoundedRectangle(cornerRadius: 2, style: .circular)
                            .trim(from: 0.61, to: 0.64)
                            .stroke(Color(.blue), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.init(degrees: rotation))
                    }
                }
                .frame(width: size.width, height: size.width)
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(.blue)
                        .frame(height: 2.5)
                        .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                        .offset(y: isScanning ? size.width : 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            Spacer(minLength: 15)

            Button(action: {}, label: {
                Image(systemName: "qrcode.viewfinder")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            })

            Spacer(minLength: 45)
        }
        .padding(15)
        .onAppear(perform: checkCameraPermission)
        .alert(errorMessage, isPresented: $showError) {
            if cameraPermission == .denied {
                Button("Settings") {
                    let settingString = UIApplication.openSettingsURLString
                    if let settingsURL = URL(string: settingString) {
                        openURL(settingsURL)
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
        // `onChange` ile taranan QR kodunu yakalayıp işlem yapıyoruz
        .onChange(of: qrDelegate.scannedCode) { newValue in
            if let code = newValue {
                session.stopRunning() // Tarama işlemi durduruluyor
                DeActivateScannerAnimation() // Animasyon durduruluyor
                print("Ürün Barkodu: \(code)")
                scannedCode = code
                showProductView = true // Sheet açmak için durumu güncelliyoruz
            }
        }
        .sheet(isPresented: $showProductView) {
            if let code = scannedCode {
                ProductView(barcode: code)
            }
        }
    }

    // Kamera izni kontrol fonksiyonu
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                setupCamera()
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    setupCamera()
                } else {
                    cameraPermission = .denied
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Lütfen kameraya erişim izni verin.")
            default: break
            }
        }
    }

    // Kamera ayarlama fonksiyonu
    func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                presentError("Bilinmeyen cihaz hatası.")
                return
            }
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("Girdi/Çıktı hatası.")
                return
            }
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            qrOutput.metadataObjectTypes = [
                .ean13,
                .ean8,
                .code128,
                .code39,
                .code93
            ]
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            activateScannerAnimation()
        } catch {
            presentError("Kamera ayarlanamadı.")
        }
    }
    // Hata mesajı gösterme fonksiyonu
    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }

    // Tarama animasyonu başlatma fonksiyonu
    func activateScannerAnimation() {
        withAnimation(.easeInOut(duration: 0.85).delay(0.3).repeatForever(autoreverses: true)) {
            isScanning = true
        }
    }

    // Tarama animasyonunu durdurma fonksiyonu
    func DeActivateScannerAnimation() {
        withAnimation(.easeInOut(duration: 0.85)) {
            isScanning = false
        }
    }
}
#Preview {
    ScannerView()
}
