//
//  VStackExample.swift
//  Flags
//
//  Created by Ben Gottlieb on 7/11/20.
//

import SwiftUI

struct VStackExample: View {
	@EnvironmentObject var dataStore: DataStore
	@State var useLazyLists = true
	@State var sortReverseAlpha = false
	
	var display: [Emoji] {
		if sortReverseAlpha { return Array(dataStore.emoji.reversed()) }
		return dataStore.emoji
	}
	
	var body: some View {
		ZStack(alignment: .top) {
			ScrollView() {
				if useLazyLists {
					LazyVStack() {
						ForEach(display) { disp in RowView(display: disp) }
					}
				} else {
					VStack() {
						ForEach(display) { disp in RowView(display: disp) }
					}
				}
			}
			
			HStack() {
				Toggle("Lazy Lists", isOn: $useLazyLists)
				Spacer(minLength: 20)
				Picker("", selection: $sortReverseAlpha.animation()) {
					Text("A-Z").tag(false)
					Text("Z-A").tag(true)
				}
				.labelsHidden()
				.pickerStyle(SegmentedPickerStyle())
			}
			.padding(5)
		}
		.navigationTitle("")
		.navigationBarHidden(true)
	}
}

struct VStackExample_Previews: PreviewProvider {
	static var previews: some View {
		VStackExample()
			.environmentObject(DataStore())
	}
}
