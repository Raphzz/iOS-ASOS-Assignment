//
//  iOS_Dev_AssignmentTests.swift
//  iOS-Dev-AssignmentTests
//
//  Created by Raphael Velasqua on 07/09/2022.
//

import XCTest
import Combine
@testable import iOS_Dev_Assignment

class iOS_Dev_AssignmentTests: XCTestCase {

    private let mockService = HomeViewServiceMock()
        
    var viewModelMock: HomeViewViewModel!
    
    var cancellables = Set<AnyCancellable>()
    
    func testFetchCompanyInfoWithSuccess() {
        mockService.success = true
        
        viewModelMock = HomeViewViewModel(service: mockService)
        viewModelMock.fetchCompanyInfo()
        
        XCTAssertEqual(viewModelMock.companyInfo?.name, "SpaceX")
    }
    
    func testFetchCompanyInfoWithError() {
        mockService.success = false
        mockService.fetchCompanyInfo { (result) in
            switch result{
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssert(error == .invalidJSON)
            }
        }
    }
    
    func testFetchAllLaunchesWithSuccess() {
        
        let updateExpectation = expectation(description: "Mission list should fetch right amount")
        
        mockService.success = true
        viewModelMock = HomeViewViewModel(service: mockService)
        
        viewModelMock.$missionList
            .dropFirst()
            .sink(receiveValue: { missions in
                XCTAssertEqual(missions.count, 10)
                updateExpectation.fulfill()
            }).store(in: &cancellables)
        
        viewModelMock.fetchMissionList()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchAllLaunchesWithError() {
        mockService.success = false
        mockService.fetchMissionList { (result) in
            switch result{
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssert(error == .invalidJSON)
            }
        }
    }
    
    func testPrepareCompanyTextBlock() {
        mockService.success = true
        
        viewModelMock = HomeViewViewModel(service: mockService)
        viewModelMock.fetchCompanyInfo()
        viewModelMock.prepareCompanyText()
        
        XCTAssertEqual(viewModelMock.formattedCompanyTextBlock, "SpaceX was founded by Elon Musk in 2002. It has now 9500 employees, 3 launch sites, and is valued at USD 985555968")
    }
    
    func testGetDaysSinceOrFrom() {
        
        viewModelMock = HomeViewViewModel(service: mockService)
        
        let currentDate = Date(timeIntervalSince1970: 1662734685) // Friday, 9 September 2022
        let pastDate = Date(timeIntervalSince1970: 1662624451) // Thursday, 8 September 2022
        let futureDate = Date(timeIntervalSince1970: 1662834741) // Saturday, 10 September 2022
        
        // since
        XCTAssertEqual(viewModelMock.getDaysSinceOrFrom(today: currentDate, date: pastDate).0, .since)
        XCTAssertEqual(viewModelMock.getDaysSinceOrFrom(today: currentDate, date: pastDate).1, 1)
        
        // from
        XCTAssertEqual(viewModelMock.getDaysSinceOrFrom(today: currentDate, date: futureDate).0, .from)
        XCTAssertEqual(viewModelMock.getDaysSinceOrFrom(today: currentDate, date: futureDate).1, 1)
    }
    
    func testFilterSuccessfulMissions() {
        
        let updateExpectation = expectation(description: "Mission list should fetch right amount")
        
        mockService.success = true
        viewModelMock = HomeViewViewModel(service: mockService)
        
        viewModelMock.$missionList
            .dropFirst(2)
            .sink(receiveValue: { missions in
                XCTAssertEqual(missions.count, 7)
                updateExpectation.fulfill()
            }).store(in: &cancellables)
        
        viewModelMock.fetchMissionList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.viewModelMock.filterSuccessfulMissions()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testChangeMissionOrdering() {
        
        let updateExpectation = expectation(description: "Mission list should sort differently")
        
        mockService.success = true
        viewModelMock = HomeViewViewModel(service: mockService)
        
        viewModelMock.$missionList
            .dropFirst(2)
            .sink(receiveValue: { missions in
                XCTAssertEqual(missions.first?.name, "CRS-2")
                updateExpectation.fulfill()
            }).store(in: &cancellables)
        
        viewModelMock.fetchMissionList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.viewModelMock.changeOrdering()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
