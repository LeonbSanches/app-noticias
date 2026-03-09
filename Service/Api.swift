//
//  Api.swift
//  AppNotice
//
//  Created by CPINfo on 03/03/26.
//

import Foundation

class Api {
    
    private let API_Key = "7cb5720337f74c2186c83dfbf8fde9a6"
    
    func getNotice()async throws -> [Article] {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(API_Key)")
        else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse {
            print("Status code: \(httpResponse.statusCode)")
        }
        do {
            let notice = try JSONDecoder().decode(Notice.self, from: data)
            print("Decodificação bem-sucedida: \(notice)")
            return notice.articles ?? []
        } catch {
            print("Erro de decodificação: \(error)")
            print(String(data: data, encoding: .utf8) ?? "Dados não são string")
            throw error
        }
    }
    
    
    // Novo método para buscar notícias por categoria
    func getNotice(category: String? = nil) async throws -> [Article] {
        var urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(API_Key)"
        if let category = category, !category.isEmpty {
            urlString += "&category=\(category)"
        }
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse {
            print("Status code: \(httpResponse.statusCode)")
        }
        do {
            let notice = try JSONDecoder().decode(Notice.self, from: data)
            print("Decodificação bem-sucedida: \(notice)")
            return notice.articles ?? []
        } catch {
            print("Erro de decodificação: \(error)")
            print(String(data: data, encoding: .utf8) ?? "Dados não são string")
            throw error
        }
    }
}
