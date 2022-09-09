//
//  HomeView.swift
//  iOS-Dev-Assignment
//
//  Created by Raphael Velasqua on 07/09/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewViewModel
    
    @State private var showingSheet = false
    @State private var showingOptions = false
    @State private var showWebView = false
    
    @State private var webViewLink: String?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                companyInfoBlock
                launchesHeader
                List(viewModel.missionList) { mission in
                    MissionRow(launchMission: mission, launchInterval: viewModel.getDaysSinceOrFrom(date: mission.dateObject))
                        .onTapGesture {
                        showingOptions.toggle()
                    }.confirmationDialog("Open a link:", isPresented: $showingOptions, titleVisibility: .visible) {
                        if let youtube = mission.links?.webcast { Button("Youtube") {
                            webViewLink = youtube
                            showWebView.toggle()
                        }}
                        
                        if let article = mission.links?.article { Button("Article") {
                            webViewLink = article
                            showWebView.toggle()
                        }}
                        
                        if let wikipedia = mission.links?.wikipedia { Button("Wikipedia") {
                            webViewLink = wikipedia
                            showWebView.toggle()
                        }}
                    }.sheet(isPresented: $showWebView) {
                        WebView(url: URL(string: webViewLink ?? ""))
                    }
                }
            }
            .onAppear(perform: {
                viewModel.fetchCompanyInfo()
                viewModel.fetchMissionList()
            })
            .navigationTitle("SpaceX")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }.tint(Color.gray)
                    .sheet(isPresented: $showingSheet) {
                        FilterSheetView(viewModel: viewModel)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private var launchesHeader: some View {
        Text("LAUNCHES")
            .padding(.top, 15)
            .padding(.leading, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 18, weight: .heavy, design: .default))
    }
    
    private var companyInfoBlock: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("COMPANY")
                .padding(.top, 15)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18, weight: .heavy, design: .default))
            Text(viewModel.formattedCompanyTextBlock).padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewViewModel())
    }
}
