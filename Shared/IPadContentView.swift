//
//  IPadContentView.swift
//  SwiftUI2
//
//  Created by ben on 7/14/20.
//

import SwiftUI

struct IPadContentView: View {
    var body: some View {
		TabView() {
			WordCloudSlide()
			PlaneOutline()
		}
		.background(Color.black)
		.edgesIgnoringSafeArea(.all)
		.tabViewStyle(PageTabViewStyle())
    }
}

struct IPadContentView_Previews: PreviewProvider {
    static var previews: some View {
        IPadContentView()
    }
}
