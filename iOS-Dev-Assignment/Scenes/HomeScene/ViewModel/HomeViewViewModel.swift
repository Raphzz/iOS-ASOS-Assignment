//
//  HomeViewViewModal.swift
//  iOS-Dev-Assignment
//
//  Created by Raphael Velasqua on 07/09/2022.
//

import Foundation
import SwiftUI

typealias DaysSinceOrFrom = (LaunchInterval, Int)

enum LaunchInterval: String {
    case from = "from"
    case since = "since"
}

final class HomeViewViewModel: ObservableObject {
    
    private let service: HomeViewServiceProtocol
    
    private let companyTextBlock = "%@ was founded by %@ in %d. It has now %d employees, %d launch sites, and is valued at USD %d"
    
    private(set) var companyInfo: CompanyInfo?
    
    private var responseList: [LaunchMission] = []
    
    @Published var shouldFilterSuccessfulMissions = false
    @Published var isAscendingOrdered = true
    
    @Published var formattedCompanyTextBlock = ""
    @Published var missionList: [LaunchMission] = []
    
    init(service: HomeViewServiceProtocol = HomeViewService()) {
        self.service = service
    }
    
    func fetchCompanyInfo() {
        service.fetchCompanyInfo { [weak self] result in
            switch result{
            case .success(let response):
                self?.companyInfo = response
                DispatchQueue.main.async {
                    self?.prepareCompanyText()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchMissionList() {
        service.fetchMissionList { [weak self] result in
            switch result{
            case .success(let response):
                DispatchQueue.main.async {
                    self?.responseList = response ?? []
                    self?.missionList = response ?? []
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func prepareCompanyText() {
        if let companyName = companyInfo?.name,
            let founderName = companyInfo?.founder,
            let year = companyInfo?.founded,
            let employees = companyInfo?.employees,
            let launchSites = companyInfo?.launchSites,
            let valuation = companyInfo?.valuation {
            
            formattedCompanyTextBlock = String(format: companyTextBlock, arguments: [companyName, founderName, year, employees, launchSites, valuation])
        } else {
            formattedCompanyTextBlock = "Error fetching company info"
        }
    }
    
    private func numberOfDaysBetweenDate(today: Date = Date(), date: Date) -> Int {
        let fromDate = Calendar.current.startOfDay(for: today)
        let toDate = Calendar.current.startOfDay(for: date)
        let numberOfDays = Calendar.current.dateComponents([.day], from: fromDate, to: toDate)
        
        guard let days = numberOfDays.day else { return 0 }
        
        return days
    }
    
    func getDaysSinceOrFrom(today: Date = Date(), date: Date) -> DaysSinceOrFrom {
        let days = numberOfDaysBetweenDate(today: today, date: date)
        let periodBetween = days < 0 ? LaunchInterval.since : LaunchInterval.from
        let positiveIfNeeded = days < 0 ? (days * -1) : days
        
        return DaysSinceOrFrom(periodBetween, positiveIfNeeded)
    }
    
    func filterSuccessfulMissions() {
        shouldFilterSuccessfulMissions = !shouldFilterSuccessfulMissions
        
        missionList = shouldFilterSuccessfulMissions ? responseList.filter { mission in
            guard let isSuccessful = mission.success else { return false }
            return isSuccessful
        } : responseList
    }
    
    func changeOrdering() {
        isAscendingOrdered = !isAscendingOrdered
        missionList.sort { (mission1, mission2) in
            if !isAscendingOrdered {
                return numberOfDaysBetweenDate(date: mission1.dateObject) > numberOfDaysBetweenDate(date: mission2.dateObject)
            } else {
                return numberOfDaysBetweenDate(date: mission1.dateObject) < numberOfDaysBetweenDate(date: mission2.dateObject)
            }
        }
    }
}
