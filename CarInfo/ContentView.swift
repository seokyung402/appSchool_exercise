//
//  ContentView.swift
//  CarInfo
//
//  Created by 이서경 on 4/16/24.
//

import SwiftUI

class CarListViewModel: ObservableObject {
    @Published var cars: [Car] = [teslaModelX, teslaModelY, kiaK5, kiaK8, kiaK9, prius, grandeurHybrid]
    @Published var elecCars: [ElectricCar] = [teslaModelX, teslaModelY]
    @Published var oilCars: [OilCar] = [kiaK5, kiaK8, kiaK9]
    @Published var hybridCars: [HybridCar] = [prius, grandeurHybrid]
}


struct ElecCarDetailView: View {
    let cars: [ElectricCar]
    let title: String
    
    var body: some View {
        List(cars) { car in
            VStack(alignment: .leading) {
                Text(car.brand)
                Text(car.modelName)
                    .font(.title)
                    .fontWeight(.bold)
                Text("1회 충전 시 \(Int( car.electricEfficiency))km 주행")
                Text("충전시간: \(Int(car.fullChargeHours))시간")
                Text("자율주행 \(car.autoLevel)단계")
            }
        }
        .navigationTitle(title)
    }
}

struct OilCarDetailView: View {
    let cars: [OilCar]
    let title: String
    
    var body: some View {
        List(cars) { car in
            VStack(alignment: .leading) {
                Text(car.brand)
                Text(car.modelName)
                    .font(.title)
                    .fontWeight(.bold)
                Text(car.isAutomaticString)
                Text(car.isGasolineString)
                Text("연비 \(String(format: "%.2f", car.fuelEfficiency))km/h")
                
            }
        }
        .navigationTitle(title)
    }
}

struct HybridCarDetailView: View {
    let cars: [HybridCar]
    let title: String
    
    var body: some View {
        List(cars) { car in
            VStack(alignment: .leading) {
                Text(car.brand)
                Text(car.modelName)
                    .font(.title)
                    .fontWeight(.bold)
                Text(car.isGasolineString)
                Text("연비 \(String(format: "%.2f", car.fuelEfficiency))km/h")
                Text("자율주행 \(car.autoLevel)단계")
            }
        }
        .navigationTitle(title)
    }
}

struct AddCarView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var carViewModel: CarListViewModel
    
    @State private var gearType: String = ""
    @State private var brand: String = ""
    @State private var modelName: String = ""
    @State private var isGasoline: Bool = true
    @State private var fuelEfficiency: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Gear Type", selection: $gearType) {
                    Text("Electric").tag("Electric")
                    Text("Oil").tag("Oil")
                    Text("Hybrid").tag("Hybrid")
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("Brand", text: $brand)
                TextField("Model Name", text: $modelName)
                
                Toggle("Gasoline", isOn: $isGasoline)
                
                TextField("Fuel Efficiency", text: $fuelEfficiency)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add Car")
            .navigationBarItems(trailing:
                                    Button("Save") {
                saveCar()
            }
            )
        }
    }
    
    private func saveCar() {
        guard let efficiency = Double(fuelEfficiency) else { return }
        
        switch gearType {
        case "Electric":
            let car = ElectricCar(brand: brand, modelName: modelName, year: 2024, doorCount: 4, weight: 2000, height: 1500, electricEfficiency: efficiency, fullChargeHours: 2, autoLevel: 2)
            carViewModel.elecCars.append(car)
        case "Oil":
            let car = OilCar(brand: brand, modelName: modelName, year: 2024, doorCount: 4, weight: 2000, height: 1500, isAutomatic: true, fuelEfficiency: efficiency, isGasoline: isGasoline)
            carViewModel.oilCars.append(car)
        case "Hybrid":
            let car = HybridCar(brand: brand, modelName: modelName, year: 2024, doorCount: 4, weight: 2000, height: 1500, isAutomatic: true, fuelEfficiency: efficiency, isGasoline: isGasoline, autoLevel: 2)
            carViewModel.hybridCars.append(car)
        default:
            break
        }
        
        // Dismiss the view after saving
        presentationMode.wrappedValue.dismiss()
    }
}


struct ContentView: View {
    @StateObject private var carViewModel = CarListViewModel()
    @State private var showAddCarView = false
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ElecCarDetailView(cars: carViewModel.elecCars, title: "전기")) {
                    Text("전기")
                }
                NavigationLink(destination: OilCarDetailView(cars: carViewModel.oilCars, title: "내연기관")) {
                    Text("내연기관")
                }
                NavigationLink(destination: HybridCarDetailView(cars: carViewModel.hybridCars, title: "하이브리드")) {
                    Text("하이브리드")
                }
            }
            .navigationTitle("TopGear")
            .navigationBarItems(trailing:
                                    Button(action: {
                showAddCarView.toggle()
            }) {
                Image(systemName: "plus")
            }
            )
            .sheet(isPresented: $showAddCarView) {
                AddCarView(carViewModel: carViewModel)
            }
        }
    }
}



#Preview {
    ContentView()
}
