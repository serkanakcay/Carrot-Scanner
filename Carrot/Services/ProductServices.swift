//
//  ProductServices.swift
//  Carrot
//
//  Created by serkan on 17.09.2024.
//
import Foundation

class ProductService {
    func fetchProduct(by barcode: String, completion: @escaping (Result<Product, Error>) -> Void) {
        let urlString = "https://world.openfoodfacts.org/api/v2/product/\(barcode).json"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Geçersiz URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Veri alınamadı"])))
                return
            }

            do {
                let result = try JSONDecoder().decode(OpenFoodFactsResponse.self, from: data)
                if let productData = result.product {
                    completion(.success(productData))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Ürün bulunamadı."])))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct OpenFoodFactsResponse: Decodable {
    let product: Product?
}
