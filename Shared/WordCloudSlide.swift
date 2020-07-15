//
//  WordCloudSlide.swift
//  SwiftUI2
//
//  Created by Ben Gottlieb on 7/14/20.
//

import SwiftUI

struct WordCloudSlide: View {
	@Namespace var animation
	static let activeWords = ["Grids", "Map", "Lazy Stacks", "ProgressDisplay", "VideoPlayer", "Label", "ColorPicker", "matchGeometryEffect", "ScrollViewReader", "New App architecture", "TextEditor", "Link", "DatePicker", "Disclosures", "AppStorePreview", "Outline Lists", "ToolbarItem"]
	static let inactiveWords = ["SpriteView", "Sidebars in NavigationView", "FileDocument", "fullScreenMode", "New date interpolation", "TextField.nameChanged", "New SFSymbols", "exportFiles", "AppStorage", "ScaledMetric", "SceneStorage", "StateObject"]
	static var allWords: [String] { (activeWords + inactiveWords).shuffled() }

	@State var words = Self.allWords
	
	static var fontSize: CGFloat = SwiftUI2App.isBigScreen ? 33 : 16
	static var activeFont: UIFont { UIFont.boldSystemFont(ofSize: fontSize) }
	static var inactiveFont: UIFont { UIFont.systemFont(ofSize: fontSize) }
	static let activeColor = Color.white
	static let inactiveColor = Color(.displayP3, white: 0.8, opacity: 0.75)
	
	struct LaidOutWord: Identifiable {
		let word: String
		let width: CGFloat
		let isActive: Bool
		var id: String { word }
	}
	
	struct Row: Identifiable {
		let words: [LaidOutWord]
		var id: String { words.map({ $0.word }).joined() }
	}
	
	func rows(in proxy: GeometryProxy) -> [Row] {
		let fudgeFactor: CGFloat = 1.2
		let buffer: CGFloat = 30
		let rowWidth = proxy.size.width
		var availableWidth = rowWidth
		var rows: [Row] = []
		var row: [LaidOutWord] = []
		
		for word in words {
			let active = isActive(word)
			let attributed = NSAttributedString(string: word, attributes: [.font: active ? Self.activeFont : Self.inactiveFont])
			let width = attributed.size().width * fudgeFactor + buffer
			if width > availableWidth, !row.isEmpty {
				rows.append(Row(words: row))
				row = [LaidOutWord(word: word, width: width, isActive: active)]
				availableWidth = rowWidth - width
			} else {
				row.append(LaidOutWord(word: word, width: width, isActive: active))
				availableWidth -= width
			}
		}
		
		if !row.isEmpty { rows.append(Row(words: row)) }
		return rows
	}
	
	func isActive(_ word: String) -> Bool { Self.activeWords.contains(word) }
	
	var body: some View {
		ZStack(alignment: .topLeading) {
			Rectangle()
				.fill(Color.black)

			GeometryReader() { proxy in
				VStack() {
					Spacer()
					ForEach(self.rows(in: proxy)) { row in
						WordRow(row: row, animation: self.animation)
							.padding()
					}
					Spacer()
				}
			}
			
			Button(action: { withAnimation() { self.words = Self.allWords } }) {
				Image(systemName: "shuffle")
					.font(.body)
					.foregroundColor(.white)
					.padding()
			}
		}
		.edgesIgnoringSafeArea(.all)
	}

	struct WordRow: View {
		let row: Row
		let animation: Namespace.ID
		
		var body: some View {
			HStack() {
				Spacer()
				ForEach(row.words) { word in
					Text(word.word)
						.matchedGeometryEffect(id: word.word, in: animation)
						.font(Font(word.isActive ? WordCloudSlide.activeFont.ctFont : WordCloudSlide.inactiveFont.ctFont))
						.foregroundColor(word.isActive ? WordCloudSlide.activeColor : WordCloudSlide.inactiveColor)
					Spacer()
				}
			}
		}
	}

}

extension UIFont {
	var ctFont: CTFont {
		CTFontCreateWithFontDescriptor(self.fontDescriptor, 0, nil)
	}
}

struct WordCloudSlide_Previews: PreviewProvider {
	static var previews: some View {
		WordCloudSlide()
	}
}
