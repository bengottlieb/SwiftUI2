//
//  SwiftUI2App.swift
//  Shared
//
//  Created by Ben Gottlieb on 7/11/20.
//

import SwiftUI
import UIKit

@main
struct SwiftUI2App: App {
	@AppStorage("fav") var favorite = 1
	let dataStore = DataStore()
	var body: some Scene {
		WindowGroup {
			if Self.isBigScreen {
				IPadContentView()
					.environmentObject(dataStore)
			} else {
				IPhoneContentView()
					.environmentObject(dataStore)
			}
		}
	}
}

extension SwiftUI2App {
	static var isBigScreen: Bool {
		#if os(iOS)
			return UIDevice.current.userInterfaceIdiom == .pad
		#else
			return true
		#endif
	}
}
