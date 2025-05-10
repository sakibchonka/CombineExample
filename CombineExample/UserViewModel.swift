//
//  UserViewModel.swift
//  CombineExample
//
//  Created by Mohammed Saqib on 10/05/25.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
	@Published var users: [User] = []
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	
	private var cancellables = Set<AnyCancellable>()
	
	func fetchUsers() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
			errorMessage = "Invalid URL"
			return
		}
		
		isLoading = true
		
		URLSession.shared.dataTaskPublisher(for: url)
			.map(\.data)
			.decode(type: [User].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.sink { [weak self] completion in
				self?.isLoading = false
				if case let .failure(error) = completion {
					self?.errorMessage = error.localizedDescription
				}
				
			} receiveValue: { [weak self] users in
				self?.users = users
			}
			.store(in: &cancellables)
	}
}
