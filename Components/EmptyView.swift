//
//  EmptyView.swift
//  AppNotice
//
//  Created by CPINfo on 03/03/26.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.gray)
                .scaledToFill()
                .frame(width: 400, height: 100)
            
            Text("No Articles Available")
                .font(.headline)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    EmptyView()
}

