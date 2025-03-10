//
//  FeedView.swift
//  Runr
//
//  Created by Noah Moran on 6/1/2025.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 32) {
                    ForEach(viewModel.posts) { post in
                        NavigationLink(destination: RunDetailView(post: post)) {
                            FeedCell(post: post)
                        }
                        .buttonStyle(PlainButtonStyle()) // Removes default button styling
                    }
                }
                .padding(.top, 8)
            }
            .onAppear {
                print("DEBUG: FeedView appeared")
                Task {
                    await viewModel.fetchPosts()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Runr")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: MessagesView()) { // Opens messaging screen
                        Image(systemName: "paperplane")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}


#Preview {
    FeedView()
}




