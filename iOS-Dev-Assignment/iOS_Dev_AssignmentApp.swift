//
//  iOS_Dev_AssignmentApp.swift
//  iOS-Dev-Assignment
//
//  Created by Raphael Velasqua on 07/09/2022.
//

import SwiftUI

@main
struct iOS_Dev_AssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewViewModel())
        }
    }
}
