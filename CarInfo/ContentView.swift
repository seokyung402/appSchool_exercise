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
                Text("자동변속")
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

struct ContentView: View {
    @StateObject private var carViewModel = CarListViewModel()
    
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
        }
    }
}



#Preview {
    ContentView()
}
