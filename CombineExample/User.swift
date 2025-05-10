//
//  User.swift
//  CombineExample
//
//  Created by Mohammed Saqib on 10/05/25.
//


struct User: Codable, Identifiable {
	let id: Int
	let name: String
	let email: String
}
