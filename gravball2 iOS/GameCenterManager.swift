//
//  GameCenterManager.swift
//  gravball2 iOS
//
//  Created by Daniel Roberts on 6/23/25.
//
import SpriteKit
import SwiftUI
import CoreMotion
import GameKit

// Game Center Manager
class GameCenterManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var leaderboardScores: [GKLeaderboard.Entry] = []
    @Published var showLeaderboardSheet =  false
    @Published var showRestartSheet = false
    private let leaderboardID = "com.gravballhd.leaderboard1" // Replace with your leaderboard ID
    
    init() {
        authenticatePlayer()
    }
    
    func authenticatePlayer() {
        // System Internals: GKLocalPlayer uses iOS's Game Center authentication system, tied to the user's iCloud account.
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { [weak self] viewController, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Authentication error: \(error.localizedDescription)")
                self.isAuthenticated = false
                return
            }
            
            if let viewController = viewController {
                // System Internals: Presents a UIKit-based login UI modally over the SwiftUI view hierarchy.
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootVC = windowScene.windows.first?.rootViewController {
                    rootVC.present(viewController, animated: true)
                }
            } else {
                self.isAuthenticated = localPlayer.isAuthenticated
                if self.isAuthenticated {
                    print("Player authenticated: \(localPlayer.displayName)")
                }
            }
        }
    }
    
    func submitScore(_ score: Int) async {
        guard isAuthenticated else { return }
        
        // System Internals: Uses iOS's networking stack to communicate with Game Center servers.
        do {
            try await GKLeaderboard.submitScore(
                score,
                context: 0,
                player: GKLocalPlayer.local,
                leaderboardIDs: [leaderboardID]
            )
            print("Score submitted: \(score)")
        } catch {
            print("Error submitting score: \(error.localizedDescription)")
        }
    }
    
    func loadLeaderboard() async {
        guard isAuthenticated else { return }
        
        // System Internals: Fetches leaderboard data via GameKit's asynchronous APIs.
        do {
            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: [leaderboardID])
            if let leaderboard = leaderboards.first {
                let entries = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(location: 1, length: 15))
                DispatchQueue.main.async { [weak self] in
                    self?.leaderboardScores = entries.1
                }
            }
        } catch {
            print("Error loading leaderboard: \(error.localizedDescription)")
        }
    }
}
