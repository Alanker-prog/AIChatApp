//
//  UserProfileView.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 24.06.2026.
//

import SwiftUI

struct AvatarProfileView: View {
    
    let avatar: AvatarModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text(avatar.name)
                
                ImageLoaderView(urlString: avatar.profileImageURL ?? Constants.randomeImage)
                    .ignoresSafeArea(edges: .all)
                    .frame(width: .infinity, height: .infinity)
            }
        }
    }
}

#Preview {
    AvatarProfileView(avatar: .mock)
}
