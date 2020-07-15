//
//  GridExample.swift
//  Flags
//
//  Created by Ben Gottlieb on 7/11/20.
//

import SwiftUI

struct GridExample: View {
	@EnvironmentObject var dataStore: DataStore
	@State var useHGrid = false
	@State var sortReverseAlpha = false
	@Namespace var animation
	
	var display: [Emoji] {
		if sortReverseAlpha { return Array(dataStore.emoji.reversed()) }
		return dataStore.emoji
	}

	let columnsOrRows = [GridItem(.adaptive(minimum: 100)), GridItem(.adaptive(minimum: 50))]
	var body: some View {
		ScrollViewReader() { content in
			VStack() {
				HStack() {
					ForEach(["😀", "🐶", "🍎", "🧡", "🚙", "📟"], id: \.self) { emoji in
						Button(action: { withAnimation() { content.scrollTo(emoji, anchor: .top) } }, label: { Text(emoji) })
					}
				}
				ScrollView(useHGrid ? .horizontal : .vertical) {
					ZStack(alignment: .top) {
						if useHGrid {
							LazyHGrid(rows: columnsOrRows) {
								ForEach(display) { disp in CellView(display: disp)
									.matchedGeometryEffect(id: disp.id, in: animation)
								}
							}
						} else {
							LazyVGrid(columns: columnsOrRows) {
								ForEach(display) { disp in CellView(display: disp)
									.matchedGeometryEffect(id: disp.id, in: animation)
								}
							}
						}
					}
				}
			}

			HStack() {
				Toggle("Use HGrid", isOn: $useHGrid.animation())
					.padding(.horizontal)
			}
			.background(Color.white.opacity(0.5))
		}
		.navigationTitle("")
		.navigationBarHidden(true)
	}
}

struct GridExample_Previews: PreviewProvider {
	static var previews: some View {
		GridExample()
			.environmentObject(DataStore())
	}
}
