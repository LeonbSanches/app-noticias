import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeModelView()
    @State private var searchText: String = ""
    
    // Mapeamento de categoria para ícone SF Symbols
    private let categoryIcons: [String: String] = [
        "business": "briefcase",
        "entertainment": "tv",
        "general": "globe",
        "health": "heart",
        "science": "atom",
        "sports": "sportscourt",
        "technology": "desktopcomputer"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Barra de filtro horizontal com ícones
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.categories, id: \.self) { category in
                            Button(action: {
                                viewModel.selectedCategory = category
                            }) {
                                VStack(spacing: 4) {
                                    Image(systemName: categoryIcons[category, default: "questionmark.circle"])
                                        .font(.title2)
                                        .foregroundColor(viewModel.selectedCategory == category ? .white : .accentColor)
                                        .padding(8)
                                        .background(viewModel.selectedCategory == category ? Color.accentColor : Color(.systemGray5))
                                        .clipShape(Circle())
                                    Text(category.capitalized)
                                        .font(.caption)
                                        .foregroundColor(viewModel.selectedCategory == category ? .accentColor : .primary)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding([.horizontal, .top])
                }
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

