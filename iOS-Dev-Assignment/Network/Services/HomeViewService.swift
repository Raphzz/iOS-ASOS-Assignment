//
//  HomeViewServices.swift
//  iOS-Dev-Assignment
//
//  Created by Raphael Velasqua on 07/09/2022.
//

import Foundation

protocol HomeViewServiceProtocol {
    func fetchCompanyInfo (completionHandler: @escaping (Result<CompanyInfo, ServiceFetchError>) -> Void)
    func fetchMissionList (completionHandler: @escaping (Result<[LaunchMission]?, ServiceFetchError>) -> Void)
}

class HomeViewService: BaseService, HomeViewServiceProtocol {
    
    private let cache = CacheManager()
    
    func fetchCompanyInfo (completionHandler: @escaping (Result<CompanyInfo, ServiceFetchError>) -> Void) {
        
        fetch(listOf: CompanyInfo.self, withURL: url(withPath: APIConstants.urls.companyInfo)) { [weak self] result in
            switch result {
            case .success(let company):
                self?.cache.save(company)
                completionHandler(Result.success(company))
            case .failure(let error):
                guard let cachedCompanyInfo = self?.getCachedCompanyInfo() else {
                    completionHandler(Result.failure(error))
                    return
                }
                completionHandler(Result.success(cachedCompanyInfo))
            }
        }
    }
    
    func fetchMissionList(completionHandler: @escaping (Result<[LaunchMission]?, ServiceFetchError>) -> Void) {
        
        fetch(listOf: [LaunchMission].self, withURL: url(withPath: APIConstants.urls.allLaunches)) { [weak self] result in
            switch result {
            case .success(let missions):
                self?.cache.save(missions)
                completionHandler(Result.success(missions))
            case .failure(let error):
                guard let missions = self?.getCachedMissions() else {
                    completionHandler(Result.failure(error))
                    return
                }
                completionHandler(Result.success(missions))
            }
        }
    }
}

extension HomeViewService {
    func getCachedCompanyInfo() -> CompanyInfo? {
        return self.cache.get(CompanyInfo.self)
    }
    
    func getCachedMissions() -> [LaunchMission]? {
        return self.cache.get([LaunchMission].self)
    }
}
