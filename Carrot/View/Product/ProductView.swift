import SwiftUI

struct ProductView: View {
    @StateObject private var viewModel = ProductViewModel()
    let barcode: String

    var body: some View {
        NavigationStack {
            ZStack {
                // Arka plan için LinearGradient
                LinearGradient(gradient: Gradient(colors: [Color.white, .bGcolor]),
                               startPoint: .center,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)  // Gradient tüm ekrana uygulanacak

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if let product = viewModel.product {
                            VStack(alignment: .leading, spacing: 20) {
                                if let imageUrlString = product.imageURL, let imageUrl = URL(string: imageUrlString) {
                                    AsyncImage(url: imageUrl) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxHeight: 200)
                                                .cornerRadius(10)
                                        case .failure:
                                            Text("Resim yüklenemedi.")
                                                .foregroundColor(.red)
                                        @unknown default:
                                            Text("Bilinmeyen bir hata oluştu.")
                                        }
                                    }
                                    .padding(.bottom, 20)
                                } else {
                                    Text("Resim mevcut değil.")
                                        .foregroundColor(.gray)
                                }

                                // Ürün adı
                                Text("Ürün Adı: \(product.productName ?? "Bilinmiyor")")
                                    .font(.title)
                                    .padding(.bottom, 10)

                                // Negatifler ve Pozitifler
                                productNutrientsView(product: product)

                                if let nutriscoreData = product.nutriscoreData {
                                    nutriscoreView(nutriscoreData: nutriscoreData)
                                }
                            }
                            .padding()
                        } else if let errorMessage = viewModel.errorMessage {
                            Text("Hata: \(errorMessage)")
                                .foregroundColor(.red)
                                .padding()
                        } else {
                            Text("Barkod ile ürün bilgileri getiriliyor: \(barcode)...")
                                .padding()
                        }
                    }
                    .padding()
                    .onAppear {
                        viewModel.fetchProduct(by: barcode)
                    }
                }
            }
        }
    }

    func productNutrientsView(product: Product) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            // Negatifler
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Negatifler")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    // NutriscoreData'dan negatif puanı getiriyoruz
                    if let negativePoints = product.nutriscoreData?.negativePoints {
                        ZStack {
                            // Dikdörtgen arka plan
                            Rectangle()
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color.bGcolor.opacity(0.2), Color.white]),
                                                   startPoint: .bottom,  // Gradyan alttan başlar
                                                   endPoint: .top)  // Yukarıya doğru biter
                                )
                                .frame(width: 120, height: 20)  // İstediğiniz boyut
                                .cornerRadius(5)  // Kenarları yuvarlak
                                .overlay(  // Kenarlarına stroke ekleme
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 1)  // Stroke rengi ve kalınlığı
                                )
                            
                            // İçerideki text
                            Text("Negatif Puan: \(negativePoints)")
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                    }
                }

                Divider()
                nutrientRow(title: "Enerji", value: product.nutriments?.energyKcal, unit: "kcal", points: product.nutriscoreData?.energyPoints ?? 0, maxPoints: 10, isPositive: false)
                Divider()
                nutrientRow(title: "Yağ", value: product.nutriments?.fat100g, unit: "g", points: product.nutriscoreData?.saturatedFatPoints ?? 0, maxPoints: 10, isPositive: false)
                Divider()
                nutrientRow(title: "Doymuş Yağ", value: product.nutriments?.saturatedFat100g, unit: "g", points: product.nutriscoreData?.saturatedFatPoints ?? 0, maxPoints: 10, isPositive: false)
                Divider()
                nutrientRow(title: "Şeker", value: product.nutriments?.sugars100g, unit: "g", points: product.nutriscoreData?.sugarsPoints ?? 0, maxPoints: 15, isPositive: false)
                Divider()
                nutrientRow(title: "Tuz", value: product.nutriments?.salt100g, unit: "g", points: product.nutriscoreData?.sodiumPoints ?? 0, maxPoints: 20, isPositive: false)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )

            // Pozitifler
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Pozitifler")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    // NutriscoreData'dan negatif puanı getiriyoruz
                    if let positivePoints = product.nutriscoreData?.positivePoints {
                        ZStack {
                            // Dikdörtgen arka plan
                            Rectangle()
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color.bGcolor.opacity(0.2), Color.white]),
                                                   startPoint: .bottom,  // Gradyan alttan başlar
                                                   endPoint: .top)  // Yukarıya doğru biter
                                )
                                .frame(width: 120, height: 20)  // İstediğiniz boyut
                                .cornerRadius(5)  // Kenarları yuvarlak
                                .overlay(  // Kenarlarına stroke ekleme
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 1)  // Stroke rengi ve kalınlığı
                                )
                            
                            // İçerideki text
                            Text("Pozitif Puan: \(positivePoints)")
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                    }
                }

                Divider()
                nutrientRow(title: "Protein", value: product.nutriments?.proteins100g, unit: "g", points: product.nutriscoreData?.proteinsPoints ?? 0, maxPoints: 5, isPositive: true)
                Divider()
                nutrientRow(title: "Lif", value: product.nutriments?.fiber100g, unit: "g", points: product.nutriscoreData?.fiberPoints ?? 0, maxPoints: 5, isPositive: true)
                Divider()
                nutrientRow(title: "Meyve/Baklagiller", value: product.nutriscoreData?.fruitsVegetablesNutsColzaWalnutOliveOils, unit: "%", points: product.nutriscoreData?.fruitsVegetablesNutsColzaWalnutOliveOilsPoints ?? 0, maxPoints: 5, isPositive: true)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
    }

    func nutrientRow(title: String, value: Double?, unit: String, points: Int, maxPoints: Int, isPositive: Bool) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(title):")
                Spacer()
                if let value = value {
                    Text("\(String(format: "%.2f", value)) \(unit)")
                        .foregroundColor(.black)
                } else {
                    Text("Bilinmiyor")
                        .foregroundColor(.gray)
                }
            }

            ZStack(alignment: .topTrailing) {
                ProgressBar(value: Double(points), maxValue: Double(maxPoints), isPositive: isPositive)
                    .frame(height: 8)

                Text("\(points)/\(maxPoints)")
                    .font(.footnote)
                    .padding(.horizontal, 5)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(5)
                    .offset(y: -5)
            }
        }
    }

    func nutriscoreView(nutriscoreData: NutriscoreData) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Nutriscore ve Puanlama Detayları:")
                .font(.headline)
                .padding(.bottom, 5)

            HStack {
                Image("nutriscore-\(nutriscoreData.grade?.lowercased() ?? "unknown")")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 50)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Puan: \(nutriscoreData.grade?.uppercased() ?? "Bilinmiyor")")
                        .font(.headline)
                    Text("Toplam Puan: \(nutriscoreData.score ?? 0)")
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

// ProgressBar bileşeni
struct ProgressBar: View {
    var value: Double
    var maxValue: Double
    var isPositive: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .foregroundColor(Color.gray.opacity(0.2))
                
                let progress = CGFloat(value / maxValue) * geometry.size.width
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: progress, height: geometry.size.height)
                    .foregroundColor(colorForProgress())
                    .opacity(0.8)
            }
        }
    }
    
    func colorForProgress() -> Color {
        let percentage = value / maxValue
        if isPositive {
            switch percentage {
            case 0..<0.5:
                return Color.yellow
            case 0.5..<0.75:
                return Color.green.opacity(0.7)
            default:
                return Color.green
            }
        } else {
            switch percentage {
            case 0..<0.5:
                return Color.red
            case 0.5..<0.75:
                return Color.orange.opacity(0.7)
            default:
                return Color.orange
            }
        }
    }
}
