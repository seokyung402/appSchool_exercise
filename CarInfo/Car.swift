//
//  Car.swift
//  CarInfo
//
//  Created by 이서경 on 4/16/24.
//

import Foundation

protocol Fuel {
    var fuelEfficiency: Double { get set } // 연비
    var isGasoline: Bool { get set } // 가솔린 or 디젤
    var isAutomatic: Bool { get set }
    
    var fuelEfficiencyString: String { get }
    var isGasolineString: String { get }
    var isAutomaticString: String { get }
}

extension Fuel {
    var fuelEfficiencyString: String {
        String(format: "%.2f", fuelEfficiency)
    }
    
    var isGasolineString: String {
        isGasoline ? "가솔린" : " 디젤"
    }
    
    var isAutomaticString: String {
        isAutomatic ? "자동변속" : "수동변속"
    }
}

protocol Electric {
    var autoLevel: Int { set get }
}

class Car: Identifiable {
    var brand: String
    var modelName: String
    var year: Int
    var doorCount: Int
    var weight: Int
    var height: Int
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Int, height: Int) {
        self.brand = brand
        self.modelName = modelName
        self.year = year
        self.doorCount = doorCount
        self.weight = weight
        self.height = height
    }
}

class ElectricCar: Car {
    var electricEfficiency: Double
    var fullChargeHours: Double
    var autoLevel: Int
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Int, height: Int, electricEfficiency: Double, fullChargeHours: Double, autoLevel: Int) {
        self.electricEfficiency = electricEfficiency
        self.fullChargeHours = fullChargeHours
        self.autoLevel = autoLevel
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount, weight: weight, height: height)
    }
}


class OilCar: Car, Fuel {
    var isAutomatic: Bool
    var fuelEfficiency: Double
    var isGasoline: Bool
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Int, height: Int, isAutomatic: Bool,  fuelEfficiency: Double, isGasoline: Bool) {
        self.isAutomatic = isAutomatic
        self.fuelEfficiency = fuelEfficiency
        self.isGasoline = isGasoline
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount, weight: weight, height: height)
    }
}

class HybridCar: Car, Fuel, Electric {
    var isAutomatic: Bool
    var fuelEfficiency: Double
    var isGasoline: Bool
    var autoLevel: Int
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Int, height: Int, isAutomatic: Bool, fuelEfficiency: Double, isGasoline: Bool, autoLevel: Int) {
        self.isAutomatic = isAutomatic
        self.fuelEfficiency = fuelEfficiency
        self.isGasoline = isGasoline
        self.autoLevel = autoLevel
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount, weight: weight, height: height)
    }
}

extension Car: Hashable {
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.brand == rhs.brand && lhs.modelName == rhs.modelName && lhs.year == rhs.year
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(brand)
        hasher.combine(modelName)
        hasher.combine(year)
    }
}
