//
//  MissionRow.swift
//  iOS-Dev-Assignment
//
//  Created by Raphael Velasqua on 08/09/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MissionRow: View {
    
    var launchMission: LaunchMission
    
    var launchInterval: DaysSinceOrFrom
    
    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            missionImage
            firstTextBlock
                .padding(.top, 15)
            secondTextBlock
                .padding(.top, 15)
                .padding(.leading, 5)
            Spacer()
            statusIcon
        }
    }
    
    var missionImage: some View {
        WebImage(url: URL(string: launchMission.links?.patch.small ?? ""))
            .resizable()
            .frame(width: 40, height: 40)
            .padding(.top, 20)
            .padding(.leading, 0)
    }
    
    var firstTextBlock: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Mission:").foregroundColor(Color.gray)
            Text("Date/time:").foregroundColor(Color.gray)
            Text("Rocket:").foregroundColor(Color.gray)
            Text("Days\n\(launchInterval.0.rawValue) now:").foregroundColor(Color.gray)
        }
    }
    
    var secondTextBlock: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(launchMission.listName).lineLimit(1)
            Text(launchMission.listDate).lineLimit(1)
            Text(launchMission.listRocket).lineLimit(1)
            Text("\(launchInterval.1)").lineLimit(1)
        }
    }
    
    var statusIcon: some View {
        Image(launchMission.listSuccess ? "success" : "failure")
            .resizable()
            .frame(width: 30, height: 30)
            .padding(.trailing, 0)
            .padding(.top, 20)
    }
}
