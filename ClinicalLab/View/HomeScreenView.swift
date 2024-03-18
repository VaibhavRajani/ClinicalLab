//
//  HomeScreenView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/12/24.
//

import SwiftUI

struct HomeScreenView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Text("Home")
                        .foregroundColor(.white)
                        .font(.title)
                    Spacer()
                    Button("Log Out") {
                        ContentView()
                    }
                    .foregroundColor(.white)
                }
                .padding()
                .background(Color.customPink)
                
                // Content
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.details) { detail in
                            NavigationLink(destination: DriverDetailView(routeNo: detail.routeNo)) {
                                HStack {
                                    Group {
                                        VStack{
                                            Text("Route No.")
                                            Text("\(detail.routeNo)")
                                                .bold()
                                        }
                                        VStack{
                                            Text("Account Status")
                                            HStack{
                                                Circle()
                                                    .fill(detail.status == 0 ? Color.green : Color.gray)
                                                    .frame(width: 15, height: 15)
                                                Circle()
                                                    .fill(detail.status == 0 ? Color.gray : Color.red)
                                                    .frame(width: 15, height: 15)
                                            }
                                        }
                                        
                                        VStack{
                                            Text("Picked-up at")
                                            Text(detail.pickUp_Dt.formattedTime())
                                                .bold()
                                        }
                                        VStack{
                                            Text("Picked-up by")
                                            Text("\(detail.updatedByDriver)")
                                                .bold()
                                        }
                                        VStack{
                                            Text("Specimen Collected")
                                            Text("\(detail.numberOfSpecimens)")
                                                .bold()
                                            
                                        }
                                        VStack{
                                            Text(detail.status == 0 ? "On Time" : "Late")
                                                .foregroundColor(detail.status == 0 ? .green : .red)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundStyle(Color.black)
                                }
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                .background(Color.white)
                            }
                            
                            // Footer
                            HStack {
                                Spacer()
                                Text("Total Specimens Collected: \(viewModel.totalSpecimensCollected)")
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                        }
                    }
                }
                
                Spacer()
            }
            
        }
        .onAppear {
            viewModel.fetchDetailsForAdmin()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

#Preview {
    HomeScreenView()
}
