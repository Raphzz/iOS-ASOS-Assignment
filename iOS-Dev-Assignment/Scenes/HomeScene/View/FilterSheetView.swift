//
//  FilterSheetView.swift
//  iOS-Dev-Assignment
//
//  Created by Raphael Velasqua on 09/09/2022.
//

import SwiftUI

struct FilterSheetView: View {
    @StateObject var viewModel: HomeViewViewModal
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Spacer()
                closeButton
            }
            successfulFilterBlock
            orderingBlock
            Spacer()
        }
    }
    
    private var orderingBlock: some View {
        HStack(alignment: .top, spacing: 0) {
            Text("Ordering style:").padding().padding(.top, 5)
            Toggle(viewModel.isAscendingOrdered ? "ASC" : "DESC", isOn: $viewModel.isAscendingOrdered)
                .padding()
                .onChange(of: viewModel.isAscendingOrdered) { _ in
                    viewModel.changeOrdering()
                }
            Spacer()
        }
    }
    
    private var successfulFilterBlock: some View {
        HStack(alignment: .top, spacing: 0) {
            Text("Only shows successful missions:").padding()
            Toggle(isOn: $viewModel.shouldFilterSuccessfulMissions) {}
                .padding()
                .onChange(of: viewModel.shouldFilterSuccessfulMissions) { _ in
                    viewModel.filterSuccessfulMissions()
                }
            Spacer()
        }
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }
        .font(.title)
        .padding()
    }
}

struct FilterSheetView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSheetView(viewModel: HomeViewViewModal())
    }
}
