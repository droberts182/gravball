//
//  ContentView.swift
//  gravball2 iOS
//
//  Created by Daniel Roberts on 4/20/25.
//

import SpriteKit
import SwiftUI
import CoreMotion
import GameKit


struct PhysicsCategory {
    static let centerWheel: UInt32 = 0x1 << 0 // 1
    static let ball: UInt32 = 0x1 << 1       // 2
}


// Leaderboard Sheet View
struct LeaderboardSheetView: View {
    @ObservedObject var gameCenterManager: GameCenterManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .padding()
            
            if gameCenterManager.leaderboardScores.isEmpty {
                Text("Loading scores...")
                    .font(.title2)
            } else {
                List {
                    ForEach(Array(gameCenterManager.leaderboardScores.enumerated()), id: \.element.player.playerID) { index, entry in
                        HStack {
                            Text("\(index + 1).")
                            Text(entry.player.displayName)
                            Spacer()
                            Text("\(entry.score)")
                        }
                    }
                }
            }
            
            Button("Close") {
                dismiss()
            }
            .font(.title2)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.bottom)
        }
        .background(Color(UIColor.systemBackground))
        .presentationDetents([.large])
    }
}



// A sample SwiftUI creating a GameScene and sizing it
// at 300x400 points
struct ContentView: View {
    @StateObject private var gameCenterManager = GameCenterManager()

    var body: some View {
        GeometryReader { geometry in
            SpriteView(scene: MenuScene(size: geometry.size, gameCenterManager: gameCenterManager))
                .ignoresSafeArea()
                .onAppear {
                    // Debugging: Print size to confirm landscape
                    print("View size: \(geometry.size)")
                }
                .sheet(isPresented: $gameCenterManager.showLeaderboardSheet) {
                                    LeaderboardSheetView(gameCenterManager: gameCenterManager)
                                }
        }
        
        
        
    }
    
    
    
}

