//
//  RowView.swift
//  Flags
//
//  Created by Ben Gottlieb on 7/11/20.
//

import SwiftUI

struct RowView: View {
	let display: DisplayableItem
    var body: some View {
		HStack() {
			Text(display.imageText)
				.font(Font.system(size: 90))
			Text(display.name)
				.font(.title)
			
			Spacer()
		}
	}
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
		RowView(display: Flag.sample)
    }
}
