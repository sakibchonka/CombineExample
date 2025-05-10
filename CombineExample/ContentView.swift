//
//  ContentView.swift
//  CombineExample
//
//  Created by Mohammed Saqib on 10/05/25.
//
import SwiftUI

struct ContentView: View {
	@StateObject var viewModel = UserViewModel()
	
	var body: some View {
		
		NavigationStack {
			Group {
				if viewModel.isLoading {
					ProgressView("Loading...")
				} else if let error = viewModel.errorMessage {
					Text("error: \(error)")
						.foregroundStyle(.red)
				} else {
					List(viewModel.users) { user in
						VStack(alignment: .leading) {
							Text(user.name)
								.font(.headline)
							Text(user.email)
								.font(.subheadline)
						}
					}
				}
			}
			.navigationTitle("Users")
			.onAppear {
				viewModel.fetchUsers()
			}
		}
	}
}

#Preview {
	ContentView()
}
