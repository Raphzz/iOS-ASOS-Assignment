//
//  LaunchMission.swift
//  iOS-Dev-Assignment
//
//  Created by Raphael Velasqua on 08/09/2022.
//

import Foundation

struct MissionLinks: Codable {
    let patch: ImageLinks
    let webcast: String?
    let article: String?
    let wikipedia: String?
}

struct ImageLinks: Codable {
    let small: String
    let large: String
}

class LaunchMission: Codable {
    
    let name: String
    let date: String
    let rocket: String
    let success: Bool?
    let links: MissionLinks?
    
    let dateObject: Date
    
    private enum CodingKeys: String, CodingKey {
        case name, rocket, success, links
        case date = "date_utc"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(String.self, forKey: .date)
        rocket = try container.decode(String.self, forKey: .rocket)
        success = try? container.decode(Bool.self, forKey: .success)
        links = try? container.decode(MissionLinks.self, forKey: .links)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateObject = formatter.date(from: date) ?? Date()
    }
}

// Now conform to Identifiable
extension LaunchMission: Identifiable {
    var listName: String { return name }
    var listDate: String { return date }
    var listRocket: String { return rocket }
    var listSuccess: Bool { return success ?? true }
    var missionSuccess: MissionLinks? { return links }
}
