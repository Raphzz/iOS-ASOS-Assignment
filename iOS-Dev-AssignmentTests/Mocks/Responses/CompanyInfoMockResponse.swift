//
//  CompanyInfoMockResponse.swift
//  iOS-Dev-AssignmentTests
//
//  Created by Raphael Velasqua on 09/09/2022.
//

import Foundation

@testable import iOS_Dev_Assignment

class CompanyInfoMockResponse {

    private var companyInfo: CompanyInfo?

    init() {
        let bundle = Bundle(for: CompanyInfoMockResponse.self)

        if let path = bundle.url(forResource: "company_info_mock", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let response = try JSONDecoder().decode(CompanyInfo.self, from: data)
                self.companyInfo = response
            } catch {}
        }
    }

    func getCompanyInfo() -> CompanyInfo? {
        return companyInfo
    }
}
