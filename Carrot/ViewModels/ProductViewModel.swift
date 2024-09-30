//
//  ProductViewModel.swift
//  Carrot
//
//  Created by serkan on 17.09.2024.
//

import Foundation

import Combine

class ProductViewModel: ObservableObject {
    @Published var product: Product?
    @Published var errorMessage: String?
    
    private let productService = ProductService()
    
    func fetchProduct(by barcode: String) {
        productService.fetchProduct(by: barcode) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let product):
                    self?.product = product
                    print("Ürün alındı: \(product)")
                case .failure(let error):
                    self?.errorMessage = self?.getErrorMessage(from: error)
                    print("Hata: \(self?.errorMessage ?? "Bilinmeyen hata")")
                }
            }
        }
    }

    private func getErrorMessage(from error: Error) -> String {
        // Hata mesajlarını burada özelleştirebilirsiniz
        return error.localizedDescription
    }
}
