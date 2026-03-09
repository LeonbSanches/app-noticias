//
//  HomeModelView.swift
//  AppNotice
//
//  Created by CPINfo on 03/03/26.
//

import Foundation
internal import Combine

@MainActor
class HomeModelView: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    // Adicione as categorias disponíveis
    @Published var selectedCategory: String = "business"
    let categories = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    private let api = Api()
    
    
    // Atualize o método load para aceitar categoria
    func load(category: String? = nil) {
        Task {
            do {
                isLoading = true
                errorMessage = nil
                let result = try await api.getNotice(category: category ?? selectedCategory)
                print("API retornou \(result.count) artigos para categoria \(category ?? selectedCategory)")
                self.articles = result
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
                print("Erro ao carregar artigos: \(error)")
            }
        }
    }
    
    
        
}
