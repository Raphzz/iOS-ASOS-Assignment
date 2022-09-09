//
//  CompanyInfo.swift
//  iOS-Dev-Assignment
//
//  Created by Raphael Velasqua on 07/09/2022.
//

class CompanyInfo: Codable {
    
    let headquarters: Headquarters
    let links: Links
    let name: String
    let founder: String
    let founded: Int
    let employees: Int
    let vehicles: Int
    let launchSites: Int
    let testSites: Int
    let ceo: String
    let cto: String
    let coo: String
    let ctoPropulsion: String
    let valuation: Int
    let summary: String
    let id: String
    
    private enum CodingKeys: String, CodingKey {
        case name, founder, founded, vehicles, ceo, cto, coo, valuation, summary, id, employees, headquarters, links
        case ctoPropulsion = "cto_propulsion"
        case launchSites = "launch_sites"
        case testSites = "test_sites"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        headquarters = try container.decode(Headquarters.self, forKey: .headquarters)
        links = try container.decode(Links.self, forKey: .links)
        name = try container.decode(String.self, forKey: .name)
        founder = try container.decode(String.self, forKey: .founder)
        founded = try container.decode(Int.self, forKey: .founded)
        employees = try container.decode(Int.self, forKey: .employees)
        vehicles = try container.decode(Int.self, forKey: .vehicles)
        launchSites = try container.decode(Int.self, forKey: .launchSites)
        testSites = try container.decode(Int.self, forKey: .testSites)
        ceo = try container.decode(String.self, forKey: .ceo)
        cto = try container.decode(String.self, forKey: .cto)
        coo = try container.decode(String.self, forKey: .coo)
        ctoPropulsion = try container.decode(String.self, forKey: .ctoPropulsion)
        valuation = try container.decode(Int.self, forKey: .valuation)
        summary = try container.decode(String.self, forKey: .summary)
        id = try container.decode(String.self, forKey: .id)
    }
}
