//
//  AllLaunchesMockResponse.swift
//  iOS-Dev-AssignmentTests
//
//  Created by Raphael Velasqua on 09/09/2022.
//

import Foundation

@testable import iOS_Dev_Assignment

class AllLaunchesMockResponse {

    private var allLaunches: [LaunchMission]?

    init() {
        let bundle = Bundle(for: CompanyInfoMockResponse.self)

        if let path = bundle.url(forResource: "all_launches_mock copy", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let response = try JSONDecoder().decode([LaunchMission].self, from: data)
                self.allLaunches = response
            } catch {}
        }
    }

    func getLaunches() -> [LaunchMission]? {
        return allLaunches
    }
}
