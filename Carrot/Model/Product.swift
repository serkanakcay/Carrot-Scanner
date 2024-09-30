import Foundation

struct Product: Decodable {
    let productName: String?
    let ingredientsText: String?
    let nutriscoreGrade: String?
    let ecoscoreGrade: String?
    let imageURL: String?
    let nutriments: Nutriments?
    let nutriscoreData: NutriscoreData?  // Yeni veri ekleme
    
    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case ingredientsText = "ingredients_text"
        case nutriscoreGrade = "nutriscore_grade"
        case ecoscoreGrade = "ecoscore_grade"
        case imageURL = "image_url"
        case nutriments
        case nutriscoreData = "nutriscore_data"  // JSON'daki veriye karşılık gelen key
    }
}

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

// Yeni NutriscoreData yapısı
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
