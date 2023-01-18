//
//  TMDBSwiftUIAppApp.swift
//  TMDBSwiftUIApp
//
//  Created by Irtaza Fiaz on 21/06/2021.
//

import SwiftUI

@main
struct TMDBSwiftUIAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorColor = .clear
        print("Did Finish Launching")
        return true
    }
    
}
