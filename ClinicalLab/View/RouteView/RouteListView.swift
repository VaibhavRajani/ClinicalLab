//
//  RouteListView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/21/24.
//

import Foundation
import SwiftUI

struct RouteListView: View {
    @ObservedObject var viewModel = GetRouteViewModel()
    @State private var showingUpdatePopup = false
    @State private var selectedRouteDetail: RouteDetailResponse?
    @State private var showingAddRouteView = false
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.routeDetails, id: \.route.routeNo) { routeDetail in
                    HStack {
                        VStack(alignment: .center) {
                            Text("Route ID").bold()
                            if let routeNo = routeDetail.route.routeNo {
                                Text("\(routeNo)")
                            } else {
                                Text("N/A")
                            }
                        }
                        Spacer()
                        VStack(alignment: .center) {
                            Text("Route Name").bold()
                            Text(routeDetail.route.routeName ?? "")
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .center) {
                            Text("Driver Name").bold()
                            Text(routeDetail.route.driverName ?? "")
                        }
                    }
                    .background(Color.white)
                    .onTapGesture {
                        self.selectedRouteDetail = routeDetail
                        self.showingUpdatePopup = true
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.deleteRoute(routeNo: routeDetail.route.routeNo ?? 1)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let routeNo = viewModel.routeDetails[index].route.routeNo
                        viewModel.deleteRoute(routeNo: routeNo ?? 1)
                    }
                }
                
                .listStyle(PlainListStyle())
                .navigationTitle("")
                
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(
                    Color.customPink,
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                
            }
            .navigationBarItems(trailing: Button(action: {
                showingAddRouteView = true
            }) {
                Image(systemName: "plus")
            })
        
            if showingUpdatePopup {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showingUpdatePopup = false
                    }
                
                if let selectedRouteDetail = selectedRouteDetail {
                    UpdateRouteView(isPresented: $showingUpdatePopup, viewModel: viewModel, routeDetail: selectedRouteDetail)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .transition(.scale)
                }
            }
            if showingAddRouteView{
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showingUpdatePopup = false
                    }
                AddRouteView(isPresented: $showingAddRouteView, viewModel: viewModel)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .transition(.scale)
            }
        }
        .onAppear {
            viewModel.fetchRoutes()
        }
    }
}

#Preview {
    RouteListView(viewModel: GetRouteViewModel())
}
