//
//  SettingsView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/17/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    private let navigationItems: [NavigationItem] = [
        NavigationItem(title: "Driver", destination: AnyView(DriverListView())),
        NavigationItem(title: "Customer", destination: AnyView(CustomerListView())),
        NavigationItem(title: "Vehicle", destination: AnyView(VehicleListView())),
        NavigationItem(title: "Routes", destination: AnyView(RouteListView()))
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(navigationItems, id: \.title) { item in
                    NavigationLink(item.title, destination: item.destination)
                }
            }
            .navigationTitle("Settings")
          //  .listStyle(GroupedListStyle())
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.customPink, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NavigationItem {
    let title: String
    let destination: AnyView
}
