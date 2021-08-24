//
//  AppDelegate.swift
//  rum-demo
//
//  Created by Adam Kaczmarek on 1/11/21.
//

import UIKit
import Foundation
import Datadog

/// A global instance of Datadog `Logger`
internal fileprivate(set) var logger: Logger!

/// A global instance of `URLSession` (think: Apple's HTTP Client)
internal fileprivate(set) var urlSession: URLSession!

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Datadog.initialize(
            appContext: .init(),
            trackingConsent: .granted,
            configuration: Datadog.Configuration
                .builderUsing(
                    rumApplicationID: "<rum-app-id>",
                    clientToken: "<client-token>",
                    environment: "<env>"
                )
                .trackUIKitActions(true)
                .trackUIKitRUMViews(using: DefaultUIKitRUMViewsPredicate())
                .trackURLSession(firstPartyHosts: ["cataas.com"]) // this is the domain from which we download the cat image
                .build()
        )

        logger = Logger.builder
            .sendNetworkInfo(true)
            .printLogsToConsole(true, usingFormat: .shortWith(prefix: "[iOS App] "))
            .build()

        Datadog.setUserInfo(id: "1234", name: "Jane Doe", email: "Jane123@somewhere.com")

        Datadog.verbosityLevel = .debug
        Datadog.debugRUM = true

        Global.rum = RUMMonitor.initialize()
        Global.rum.addAttribute(forKey: "some-global-attribute", value: "and it's value")


        // Set up URLSession:
        urlSession = URLSession(
            configuration: .default,
            delegate: DDURLSessionDelegate(),
            delegateQueue: nil
        )
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
} 
