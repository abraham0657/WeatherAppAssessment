//
//  AppDelegate.swift
//  Weather
//
//  Created by Abraham Tesfamariam on 11/2/17.
//  Copyright © 2017 RJT Compuquest. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var viewController: UIViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        checkForPreviousSearch()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    /*
     @description: If a search was done previously, displays DetailViewController as the first view controller until another search is done
     @param: Void
     @return: Void
     */
    func checkForPreviousSearch() {
        if let previousSearchText = UserDefaults.standard.string(forKey: "previousSearch") {
            let navController = self.window?.rootViewController as! UINavigationController
            let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            
            _ = detailVC.view   // to instantiate objects
            detailVC.searchButton.isHidden = false
            detailVC.fetchData(cityName: previousSearchText)
            
            // store SearchTableViewController
            self.viewController = navController.viewControllers[0] as! SearchTableViewController
            navController.viewControllers = [detailVC]
        }
    }
    
    /*
     @description: returns the view controller stored as the first view controller
     @param: Void
     @return: Void
     */
    func changeRootVC() {
        guard let viewController = self.viewController else { return }
        
        let navController = self.window?.rootViewController as! UINavigationController
        navController.viewControllers = [viewController]
    }
}

