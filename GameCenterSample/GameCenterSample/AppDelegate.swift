//
//  AppDelegate.swift
//  GameCenterSample
//
//  Created by Maroof Khan on 4/27/15.
//  Copyright (c) 2015 Maroof Khan. All rights reserved.
//

import UIKit
import GameKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        return true
    }


    // MARK: Game Center Methods
    /* <--- Game Center --> */
    private var _isGameCenterEnabled = false
    private var _leaderboardIdentifier: String?
    
    var isGameCenterEnabled: Bool {
        return _isGameCenterEnabled
    }
    
    var leaderboardIdentifier: String? {
        return _leaderboardIdentifier
    }
    
    func authenticatePlayer() {
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {
            (viewController, error) in
            if let controller = viewController {
                // Type of 'controller' is 'GKHostedAuthenticateViewController'
                if let rootViewController = self.window?.rootViewController {
                    rootViewController.presentViewController(controller, animated: true, completion: nil)
                }
                
            } else {
                
                if localPlayer.authenticated {
                    self._isGameCenterEnabled = true
                    
                    localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({
                        (leaderboardIdentifier, error) -> Void in
                        if let _error = error {
                            println("\(_error.localizedDescription)")
                        } else {
                            self._leaderboardIdentifier = leaderboardIdentifier
                        }
                    })
                } else {
                    
                    self._isGameCenterEnabled = false
                }
            }
            
        }
    }
    
    func reportScore (score: Int) {
        if let leaderboardIdentfier = self.leaderboardIdentifier {
            let _score = GKScore(leaderboardIdentifier: leaderboardIdentfier)
            _score.value = Int64(score)
            
            GKScore.reportScores([_score], withCompletionHandler: { (error) -> Void in
                if let _error = error {
                    println("\(_error.localizedDescription)")
                }
            })
            
        } else {
            
            if let rootViewController = self.window?.rootViewController {
                let alertController = UIAlertController(title: "Game Center Unavaliable!", message: "Your score could not be added to the leaderboard.", preferredStyle: .Alert)
                let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                let enableGameCenter = UIAlertAction(title: "Enable Game Center", style: .Default, handler: { (action) -> Void in
                    self.authenticatePlayer()
                })
                
                alertController.addAction(dismiss)
                alertController.addAction(enableGameCenter)
                rootViewController.presentViewController(alertController, animated: true, completion: nil)
                
            }
        }
        
    }
    
    func showLeaderboard () {
        if let leaderboardIdentifier = self.leaderboardIdentifier {
            if let rootViewController = self.window?.rootViewController {
                let controller = GKGameCenterViewController()
                controller.viewState = GKGameCenterViewControllerState.Leaderboards
                controller.leaderboardIdentifier = leaderboardIdentifier
                rootViewController.presentViewController(controller, animated: true, completion: nil)
            }
        } else {
            if let rootViewController = self.window?.rootViewController {
                let alertController = UIAlertController(title: "Game Center Unavaliable!", message: "Leaderboard not avaliable.", preferredStyle: .Alert)
                let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                let enableGameCenter = UIAlertAction(title: "Enable Game Center", style: .Default, handler: { (action) -> Void in
                    self.authenticatePlayer()
                })
                
                alertController.addAction(dismiss)
                alertController.addAction(enableGameCenter)
                rootViewController.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    /* <--- ---> */
    
    
}

