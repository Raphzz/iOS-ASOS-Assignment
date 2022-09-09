//
//  HomeViewServiceMock.swift
//  iOS-Dev-AssignmentTests
//
//  Created by Raphael Velasqua on 09/09/2022.
//

import Foundation

@testable import iOS_Dev_Assignment

class HomeViewServiceMock: HomeViewServiceProtocol {
    
    private let mockCompanyInfoResponse = CompanyInfoMockResponse()
    
    private let mockAllLaunchesResponse = AllLaunchesMockResponse()
    
    var success = true
    
    func fetchCompanyInfo(completionHandler: @escaping (Result<CompanyInfo, ServiceFetchError>) -> Void) {
        if success {
            completionHandler(Result.success(mockCompanyInfoResponse.getCompanyInfo()!))
        } else {
            let errorTemp = ServiceFetchError.invalidJSON
            completionHandler(Result.failure(errorTemp))
        }
    }
    
    func fetchMissionList(completionHandler: @escaping (Result<[LaunchMission]?, ServiceFetchError>) -> Void) {
        if success {
            completionHandler(Result.success(mockAllLaunchesResponse.getLaunches()!))
        } else {
            let errorTemp = ServiceFetchError.invalidJSON
            completionHandler(Result.failure(errorTemp))
        }
    }
}
