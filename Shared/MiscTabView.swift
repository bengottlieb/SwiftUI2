//
//  MiscTabView.swift
//  Flags
//
//  Created by Ben Gottlieb on 7/11/20.
//

import SwiftUI
import MapKit
import AVKit
import StoreKit

struct MiscTabView: View {
	@State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.8337329, longitude: -87.8720396), span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
	@State private var editableText = "Here\nis\nso\nmuch\ntext!"
	@State private var selectedDate = Date()
	@State private var appPreviewVisible = false
	
	@State var player = AVPlayer(url: URL(string: "https://p-events-delivery.akamaized.net/2605bdtgclbnfypwzfkzdsupvcyzhhbx/m3u8/hls_vod_mvp.m3u8")!)
	@State var color = Color.red
	
	var body: some View {
		VStack() {
			ProgressView("")
			
			Link(destination: URL(string: "https://www.apple.com")!) {
				Label(title: { Text("Link") }, icon: { Image(systemName: "safari") })
			}
			
			NavigationLink(destination:
				Map(coordinateRegion: $region)
					.navigationTitle("Map!")
					.navigationBarHidden(false)
			) {
				Label(
					title: { Text("Map") },
					icon: { Image(systemName: "location.north") }
				)
			}
			
			NavigationLink(destination:
				VideoPlayer(player: player)
					.navigationTitle("Video!")
					.navigationBarHidden(false)
					.onDisappear {
						self.player.pause()
					}
			) {
				Label(
					title: { Text("Video") },
					icon: { Image(systemName: "film") }
				)
			}
			
			HStack() {
				Spacer()
				Label(
					title: { Text("Color") },
					icon: { Image(systemName: "star.circle.fill")
						.foregroundColor(color) }
				)
				
				ColorPicker("Colors!", selection: $color)
					.labelsHidden()
				Spacer()
			}
				
			NavigationLink(destination:
				TextEditor(text: $editableText)
					.navigationTitle("Text!")
					.navigationBarHidden(false)
			) {
				Label(
					title: { Text("Multiline Field") },
					icon: { Image(systemName: "pencil.circle") }
				)
			}
			
			Button(action: { self.appPreviewVisible.toggle() }) {
				Label(
					title: { Text("App Store Links") },
					icon: { Image(systemName: "plus.app") }
				)
			}
			
			DisclosureGroup("Date Picker") {
				DatePicker("Date Picker", selection: $selectedDate)
					.frame(width: 200, height: 25)
					.labelsHidden()
			}
			.frame(width: 175)

		}
		.appStoreOverlay(isPresented: $appPreviewVisible) { SKOverlay.AppConfiguration(appIdentifier: "1234", position: .bottom) }

		.navigationTitle("")
		.navigationBarHidden(true)
	}
}



struct MiscTabView_Previews: PreviewProvider {
	static var previews: some View {
		MiscTabView()
	}
}
