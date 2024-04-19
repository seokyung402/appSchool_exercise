//
//  ContentView.swift
//  DemoProject
//
//  Created by 이서경 on 4/17/24.
//

import SwiftUI

struct User: Codable {
    let login: String
    let avatar_url: URL
}

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
}

actor GithubService {
    func fetchUser(username: String) async throws -> User {
        let url = URL(string: "https://api.github.com/users/\(username)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(User.self, from: data)
    }
    
    func fetchRepositories(username: String) async throws -> [Repository] {
        let url = URL(string: "https://api.github.com/users/\(username)/repos")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Repository].self, from: data)
    }
}

@MainActor
class GithubViewModel: ObservableObject {
    @Published var user: User?
    @Published var repositories: [Repository] = []
    @Published var error: Error?

    let githubService = GithubService()
    
    func fetchData(username: String) async {
        do {
            error = nil
            async let fetchUser = githubService.fetchUser(username: username)
            async let fetchRepositoris = githubService.fetchRepositories(username: username)
            
            user = try await fetchUser
            repositories = try await fetchRepositoris
        } catch {
            self.error = error
        }
    }
}

struct ContentView: View {
    @State private var username = "seokyung402"
    @StateObject private var viewModel = GithubViewModel()
    
    var body: some View {
        VStack {
            TextField("Github username:", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Fetch Data") {
                Task.detached {
                    await viewModel.fetchData(username: username)
                }
            }
            
            if let user = viewModel.user {
                AsyncImage(url: user.avatar_url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width:100, height:100)
                .clipShape(Circle())
                
                Text(user.login)
                    .font(.title)
            }
            
            List(viewModel.repositories) { repo in
                VStack(alignment: .leading) {
                    Text(repo.name)
                        .font(.headline)
                    Text(repo.description ?? "No description")
                        .font(.subheadline)
                }
            }
            
            if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
            }
        }
    }
}


#Preview {
    ContentView()
}
