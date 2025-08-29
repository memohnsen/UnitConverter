//
//  ContentView.swift
//  UnitConverter
//
//  Created by Maddisen Mohnsen on 8/29/25.
//

import SwiftUI

struct ContentView: View {
    enum Units: String, CaseIterable, Identifiable {
        case KG, LB, G, OZ, ST
        var id: Self { self }
        
        var displayName: String {
            switch self {
            case .KG: return "kilograms"
            case .LB: return "pounds"
            case .G:  return "grams"
            case .OZ: return "ounces"
            case .ST: return "stones"
            }
        }
    }
    
    @State private var originalUnit: Units = .KG
    @State private var newUnit: Units = .LB
    @State private var weight: Double = 100.0
    @FocusState private var isFocused: Bool
    
    var newWeight: Double {
        let weightInKG: Double = {
            switch originalUnit {
            case .KG: return weight
            case .LB: return weight / 2.20462262
            case .G:  return weight / 1000.0
            case .OZ: return weight / 35.2739619
            case .ST: return weight / 0.157473044
            }
        }()
        switch newUnit {
        case .KG: return weightInKG
        case .LB: return weightInKG * 2.20462262
        case .G:  return weightInKG * 1000.0
        case .OZ: return weightInKG * 35.2739619
        case .ST: return weightInKG * 0.157473044
        }
    }
    
    var oldWeightFormatter: String {String(format: "%.2f", weight)}
    var newWeightFormatter: String {String(format: "%.2f", newWeight)}
    
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    Picker("Original Unit", selection: $originalUnit) {
                        Text("Kilograms").tag(Units.KG)
                        Text("Pounds").tag(Units.LB)
                        Text("Grams").tag(Units.G)
                        Text("Ounces").tag(Units.OZ)
                        Text("Stones").tag(Units.ST)
                    }
                    
                    Picker("New Unit", selection: $newUnit) {
                        Text("Kilograms").tag(Units.KG)
                        Text("Pounds").tag(Units.LB)
                        Text("Grams").tag(Units.G)
                        Text("Ounces").tag(Units.OZ)
                        Text("Stones").tag(Units.ST)
                    }
                }
                
                Section("What is the current weight?") {
                    TextField("What is the current weight?", value: $weight, format: .number)
                }
                .keyboardType(.decimalPad)
                .focused($isFocused)
                
                Section {
                    Text("\(oldWeightFormatter) \(originalUnit.displayName) is equal to \(newWeightFormatter) \(newUnit.displayName)")
                }
            }
            .navigationTitle("Unit Convertor")
            .toolbar{
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
