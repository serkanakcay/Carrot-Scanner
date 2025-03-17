import Foundation

// Ana ürün yapısı
struct Product: Decodable {
    let id: String
    let code: String
    let productName: String?
    let brands: String?
    let ingredientsText: String?
    let nutriscoreGrade: String?
    let ecoscoreGrade: String?
    let imageURL: String?
    let nutriments: Nutriments?
    let nutriscoreData: NutriscoreData?
    let ecoscoreData: EcoScoreData?  // Yeni EcoScoreData yapısı eklendi
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case code = "code"
        case productName = "product_name"
        case brands = "brands"
        case ingredientsText = "ingredients_text"
        case nutriscoreGrade = "nutriscore_grade"
        case ecoscoreGrade = "ecoscore_grade"
        case imageURL = "image_url"
        case nutriments
        case nutriscoreData = "nutriscore_data"
        case ecoscoreData = "ecoscore_data"  // EcoScoreData anahtar adı
    }
}

// Besin değerleri için yapı
struct Nutriments: Decodable {
    let energyKcal: Double?
    let fat100g: Double?
    let saturatedFat100g: Double?
    let carbohydrates100g: Double?
    let sugars100g: Double?
    let fiber100g: Double?
    let proteins100g: Double?
    let salt100g: Double?
    let sodium100g: Double?
    
    enum CodingKeys: String, CodingKey {
        case energyKcal = "energy-kcal_100g"
        case fat100g = "fat_100g"
        case saturatedFat100g = "saturated-fat_100g"
        case carbohydrates100g = "carbohydrates_100g"
        case sugars100g = "sugars_100g"
        case fiber100g = "fiber_100g"
        case proteins100g = "proteins_100g"
        case salt100g = "salt_100g"
        case sodium100g = "sodium_100g"
    }
}

// Nutri-Score detayları için yapı
struct NutriscoreData: Decodable {
    let energy: Double?
    let energyPoints: Int?
    let fiber: Double?
    let fiberPoints: Int?
    let fruitsVegetablesNutsColzaWalnutOliveOils: Double?
    let fruitsVegetablesNutsColzaWalnutOliveOilsPoints: Int?
    let saturatedFat: Double?
    let saturatedFatPoints: Int?
    let sodium: Double?
    let sodiumPoints: Int?
    let sugars: Double?
    let sugarsPoints: Int?
    let proteins: Double?
    let proteinsPoints: Int?
    let negativePoints: Int?
    let positivePoints: Int?
    let score: Int?
    let grade: String?
    
    enum CodingKeys: String, CodingKey {
        case energy = "energy"
        case energyPoints = "energy_points"
        case fiber = "fiber"
        case fiberPoints = "fiber_points"
        case fruitsVegetablesNutsColzaWalnutOliveOils = "fruits_vegetables_nuts_colza_walnut_olive_oils"
        case fruitsVegetablesNutsColzaWalnutOliveOilsPoints = "fruits_vegetables_nuts_colza_walnut_olive_oils_points"
        case saturatedFat = "saturated_fat"
        case saturatedFatPoints = "saturated_fat_points"
        case sodium = "sodium"
        case sodiumPoints = "sodium_points"
        case sugars = "sugars"
        case sugarsPoints = "sugars_points"
        case proteins = "proteins"
        case proteinsPoints = "proteins_points"
        case negativePoints = "negative_points"
        case positivePoints = "positive_points"
        case score = "score"
        case grade = "grade"
    }
}

// Eco-Score detayları için yapı
struct EcoScoreData: Decodable {
    let grade: String?
    let score: Int?
    let environmentalImpact: String?
    let positivePoints: Int?
    let negativePoints: Int?
    
    enum CodingKeys: String, CodingKey {
        case grade = "grade"
        case score = "score"
        case environmentalImpact = "environmental_impact"
        case positivePoints = "positive_points"
        case negativePoints = "negative_points"
    }
}
