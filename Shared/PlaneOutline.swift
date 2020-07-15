//
//  PlaneOutline.swift
//  SwiftUI2
//
//  Created by ben on 7/14/20.
//

import SwiftUI
import Foundation
import Combine

struct PlaneOutline: View {
	@EnvironmentObject var dataStore: DataStore
	@State var planeImage: UIImage?
	@State var imageFetcher: AnyCancellable?
	@State var backgroundColor = Color.gray
	
    var body: some View {
		HStack() {
			List(dataStore.planes, children: \.children) { plane in
				if plane.children != nil {
					Label(title: { Text(plane.name) }, icon: { Image(systemName: "paperplane.circle") })
				} else {
					Button(action: {
						if let url = plane.image {
							imageFetcher = URLSession.shared.dataTaskPublisher(for: url)
								.compactMap { UIImage(data: $0.data) }
								.replaceError(with: nil)
								.assign(to: \.planeImage, on: self)
						}
					}) {
						Label(title: { Text(plane.name) }, icon: { Image(systemName: "airplane") })
					}
				}
			}
			.listStyle(SidebarListStyle())
			.frame(width: 300)
			.toolbar {
				ToolbarItem(placement: .bottomBar) {
					Button(action: {
						backgroundColor = Color(.displayP3, red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), opacity: 1)
					} ) { Text("Swap Colors") }
				}
			}
			
			
			ZStack() {
				Rectangle()
					.fill(backgroundColor)
					.edgesIgnoringSafeArea(.all)
				
				if let image = self.planeImage {
					Image(uiImage: image)
						.resizable()
						.aspectRatio(contentMode: .fit)
				}
			}
		}
    }
}

struct PlaneOutline_Previews: PreviewProvider {
    static var previews: some View {
        PlaneOutline()
    }
}
