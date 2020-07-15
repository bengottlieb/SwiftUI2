//
//  IPhoneContentView.swift
//  Shared
//
//  Created by Ben Gottlieb on 7/11/20.
//

import SwiftUI

struct IPhoneContentView: View {
    var body: some View {
		NavigationView() {
			TabView() {
				MiscTabView()
				GridExample()
				VStackExample()
			}
			.tabViewStyle(PageTabViewStyle())
		}
		.navigationTitle("")
		.navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IPhoneContentView()
			.environmentObject(DataStore())
    }
}
