//
//  SettingsView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/17/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView{
            List {
                NavigationLink("Driver", destination: DriverListView())
                NavigationLink("Customer", destination: CustomerListView())
                NavigationLink("Vehicle", destination: VehicleListView())
                NavigationLink("Routes", destination: RouteListView())
            }
            .navigationTitle("Settings")
            .listStyle(GroupedListStyle())
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color.customPink,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)

        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// Preview provider for SwiftUI Canvas
//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
