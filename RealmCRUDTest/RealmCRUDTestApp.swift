//
//  RealmCRUDTestApp.swift
//  RealmCRUDTest
//
//  Created by John Doe on 22/11/2022.
//

import SwiftUI

@main
struct RealmCRUDTestApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                .first!
                .path
                          )
            ContentView()
        }
    }
}
