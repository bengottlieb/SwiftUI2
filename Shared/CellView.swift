//
//  CellView.swift
//  Flags
//
//  Created by Ben Gottlieb on 7/11/20.
//

import SwiftUI

struct CellView: View {
	let display: DisplayableItem
	 var body: some View {
		VStack() {
			Text(display.imageText)
				.font(Font.system(size: 40))
			Text(display.name.replacingOccurrences(of: "_", with: " "))
				.font(.caption)
			
			Spacer()
		}
	}
}

struct CellView_Previews: PreviewProvider {
	 static var previews: some View {
		CellView(display: Flag.sample)
	 }
}
