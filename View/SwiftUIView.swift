//
//  SwiftUIView.swift
//  AppNotice
//
//  Created by CPINfo on 25/02/26.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var navigate = false
    var body: some View {
        NavigationStack {
            VStack {
                Image("1024") // Substitua "AppLogo" pelo nome exato da imagem em Assets.xcassets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .padding()
                
               
                Text("AppNotice")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 16)
                
                NavigationLink(destination: HomeView(), isActive: $navigate) {
                    Button(action: {
                        navigate = true
                    }) {
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 160) // Botão menor
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(12)
                            .padding(.bottom, 32) // Aumenta o espaçamento inferior
                    }
                }
                .isDetailLink(false)
            }
            .background(Color(.systemBackground))
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SwiftUIView()
}
