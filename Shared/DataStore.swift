//
//  DataStore.swift
//  Flags
//
//  Created by Ben Gottlieb on 7/11/20.
//

import Foundation
import SwiftUI

class DataStore: ObservableObject {
	let flags: [Flag]
	let lotsOfFlags: [Flag]
	
	let emoji: [Emoji]
	let planes: [Airplane]
	
	init() {
		let flagURL = Bundle.main.url(forResource: "flags", withExtension: "json")!
		let flagData = try! Data(contentsOf: flagURL)
		func readFlags() -> [Flag] { try! JSONDecoder().decode([Flag].self, from: flagData) }
		self.flags = readFlags().sorted()
		self.lotsOfFlags = ((0...10).flatMap { _ in readFlags() }).sorted()

		let emojiURL = Bundle.main.url(forResource: "emoji", withExtension: "json")!
		let emojiData = try! Data(contentsOf: emojiURL)
		func readEmoji() -> [Emoji] { try! JSONDecoder().decode([Emoji].self, from: emojiData) }
		self.emoji = readEmoji().sorted()

		let airplaneURL = Bundle.main.url(forResource: "airplanes", withExtension: "json")!
		let airplaneData = try! Data(contentsOf: airplaneURL)
		planes = try! JSONDecoder().decode([Airplane].self, from: airplaneData)
	}
	
}

protocol DisplayableItem {
	var name: String { get }
	var imageText: String { get }
}

struct Airplane: Codable, Identifiable, Comparable, DisplayableItem {
	enum CodingKeys: String, CodingKey { case name, kind, engines, children, image }
	enum Kind: String, Codable { case `private`, passenger, fighter, bomber }
	let id = UUID()
	let name: String
	let kind: Kind?
	let engines: Int?
	let image: URL?
	let imageText = ""
	var children: [Airplane]?

	static func ==(lhs: Airplane, rhs: Airplane) -> Bool { return lhs.id == rhs.id }
	static func <(lhs: Airplane, rhs: Airplane) -> Bool { return lhs.name < rhs.name }
}

struct Emoji: Codable, Identifiable, Comparable, DisplayableItem {
	enum CodingKeys: String, CodingKey { case emoji, name }
	var id: String { emoji }
	let emoji: String
	let name: String
	var imageText: String { emoji }
	static let sample = Emoji(emoji: "🇺🇸", name: "American Flag")
	
	static func ==(lhs: Emoji, rhs: Emoji) -> Bool { return lhs.id == rhs.id }
	static func <(lhs: Emoji, rhs: Emoji) -> Bool { return lhs.name < rhs.name }
}

struct Flag: Codable, Identifiable, Comparable, DisplayableItem {
	enum CodingKeys: String, CodingKey { case flag, name, isCountry }
	let id = UUID()
	let flag: String
	let name: String
	let isCountry: Bool
	var imageText: String { flag }

	static let sample = Flag(flag: "🇺🇸", name: "USA", isCountry: true)
	
	static func ==(lhs: Flag, rhs: Flag) -> Bool { return lhs.id == rhs.id }
	static func <(lhs: Flag, rhs: Flag) -> Bool { return lhs.name < rhs.name }
}
