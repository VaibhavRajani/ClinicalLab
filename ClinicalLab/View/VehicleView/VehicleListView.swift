//
//  VehicleListView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/20/24.
//

import SwiftUI

struct VehicleListView: View {
    @ObservedObject var viewModel = GetVehicleViewModel()
    @State private var showingUpdatePopup = false
    @State private var selectedVehicle: Vehicle?
    @State private var showingAddVehicleView = false
    
    var body: some View {
        ZStack{
            List {
                ForEach(viewModel.vehicles, id: \.vehicleId) { vehicle in
                    VStack(spacing: 0) {
                        HStack {
                            Button(vehicle.plateNumber ?? ""){
                                self.selectedVehicle = vehicle
                                self.showingUpdatePopup = true
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.deleteVehicle(vehicleId: vehicle.vehicleId ?? 0)
                                } label: {
                                    Label(Strings.delete, systemImage: "trash.fill")
                                }
                            }
                        }
                        .frame(height: 44)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 1)
                            .edgesIgnoringSafeArea(.horizontal)
                        
                    }
                    .listRowInsets(EdgeInsets())
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let vehicleId = viewModel.vehicles[index].vehicleId
                        viewModel.deleteVehicle(vehicleId: vehicleId ?? 0)
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: {
                showingAddVehicleView = true
            }) {
                Image(systemName: "plus")
            })
            
            .listStyle(PlainListStyle())
            .navigationTitle("")
            
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color.customPink,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            
            if showingUpdatePopup {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showingUpdatePopup = false
                    }
                
                if let vehicle = selectedVehicle {
                   UpdateVehicleView(vehicle: vehicle, isPresented: $showingUpdatePopup, viewModel: viewModel)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .transition(.scale)
                }
            }
            
            if showingAddVehicleView{
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showingUpdatePopup = false
                    }
                AddVehicleView(isPresented: $showingAddVehicleView, viewModel: viewModel)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .transition(.scale)
            }
            
        }
        .onAppear {
            viewModel.fetchVehicles()
        }
        
    }
}
