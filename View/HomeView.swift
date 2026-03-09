//
//  HomeView.swift
//  AppNotice
//
//  Created by CPINfo on 03/03/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeModelView()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Categoria", selection: $viewModel.selectedCategory) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        Text(category.capitalized).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.horizontal, .top])
                TextField("Pesquisar...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.horizontal, .bottom])
                if viewModel.isLoading {
                    ProgressView("Carregando...")
                        .padding()
                }
                if let error = viewModel.errorMessage {
                    Text("Erro: \(error)")
                        .foregroundColor(.red)
                        .padding()
                }
                List(filteredArticles) { article in
                    VStack(alignment: .leading, spacing: 8) {
                        if let urlString = article.urlToImage, let url = URL(string: urlString) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(height: 180)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 180)
                                        .clipped()
                                        .cornerRadius(8)
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 180)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        Text(article.title ?? "Sem título")
                            .font(.headline)
                        Text(article.description ?? "Sem descrição")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Top Headlines")
            .onAppear {
                viewModel.load()
            }
            .onChange(of: viewModel.selectedCategory) { newCategory in
                viewModel.load(category: newCategory)
            }
        }
    }
    
    // Função computada para filtrar artigos
    private var filteredArticles: [Article] {
        if searchText.isEmpty {
            return viewModel.articles
        } else {
            return viewModel.articles.filter { ($0.title ?? "").localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    HomeView()
}
