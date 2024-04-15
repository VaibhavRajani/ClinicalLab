//
//  DriverListView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/17/24.
//

import Foundation
import SwiftUI


struct DriverListView: View {
    @ObservedObject var viewModel = GetDriverViewModel()
    @State private var showingUpdatePopup = false
    @State private var selectedDriver: Driver?
    @State private var showingAddDriverView = false
    
    var body: some View {
        
        ZStack{
            List {
                ForEach(viewModel.drivers, id: \.driverId) { driver in
                    VStack(spacing: 0) {
                        HStack {
                            Button(driver.driverName){
                                self.selectedDriver = driver
                                self.showingUpdatePopup = true
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.deleteDriver(driverId: driver.driverId)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
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
                            let driverId = viewModel.drivers[index].driverId
                            viewModel.deleteDriver(driverId: driverId)
                        }
                    }
            }
            .navigationBarItems(trailing: Button(action: {
                showingAddDriverView = true
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
                
                if let driver = selectedDriver {
                    UpdateDriverView(driver: driver, isPresented: $showingUpdatePopup, viewModel: viewModel)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .transition(.scale)
                }
            }
            
            if showingAddDriverView{
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showingUpdatePopup = false
                    }
                AddDriverView(isPresented: $showingAddDriverView, viewModel: viewModel)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .transition(.scale)
                
            }
            
        }
        .onAppear {
            viewModel.fetchDrivers()
        }
        
    }
}

#Preview {
    DriverListView(viewModel: GetDriverViewModel())
}
