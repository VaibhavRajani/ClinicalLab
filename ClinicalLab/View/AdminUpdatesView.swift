//
//  AdminUpdatesView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 5/10/24.
//

import Foundation
import SwiftUI

struct AdminUpdatesView: View {
    @StateObject var viewModel = WebSocketViewModel()

    var body: some View {
        Text(viewModel.latestUpdate ?? "No updates yet")
            .onAppear {
                viewModel.connect()
            }
            .onDisappear {
                viewModel.disconnect()
            }
    }
}
