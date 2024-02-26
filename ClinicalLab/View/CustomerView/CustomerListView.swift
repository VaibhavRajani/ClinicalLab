//
//  CustomerView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/18/24.
//

import Foundation
import SwiftUI


struct CustomerListView: View {
    @ObservedObject var viewModel = GetCustomerViewModel()
    @State private var showingUpdatePopup = false
    @State private var selectedCustomer: Cust?
    @State private var showingAddCustomerView = false
    
    var body: some View {
        
        ZStack{
            List {
                ForEach(viewModel.customers, id: \.customerId) { customer in
                    VStack(spacing: 0) {
                        HStack {
                            Button(customer.customerName ?? ""){
                                self.selectedCustomer = customer
                                self.showingUpdatePopup = true
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.deleteCustomer(customerId: customer.customerId ?? 0)
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
                        let customerId = viewModel.customers[index].customerId
                        viewModel.deleteCustomer(customerId: customerId ?? 0)
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: {
                showingAddCustomerView = true
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
                
                if let customer = selectedCustomer {
                    UpdateCustomerView(customer: customer, isPresented: $showingUpdatePopup, viewModel: viewModel)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .transition(.scale)
                }
            }
            
            if showingAddCustomerView{
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // Dismiss the modal when the background is tapped
                        showingUpdatePopup = false
                    }
                AddCustomerView(isPresented: $showingAddCustomerView, viewModel: viewModel)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .transition(.scale)
            }
            
        }
        .onAppear {
            viewModel.fetchCustomers()
        }
        
    }
}

#Preview {
    DriverListView(viewModel: GetDriverViewModel())
}
