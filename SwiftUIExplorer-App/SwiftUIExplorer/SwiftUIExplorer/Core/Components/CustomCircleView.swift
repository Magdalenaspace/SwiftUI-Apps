//
//  CustomCircleView.swift
//  SwiftUIExplorer
//
//  Created by Magdalena Samuel on 1/15/24.
//

import SwiftUI

struct CustomCircleView: View {
        @State private var isAnimationGradient: Bool = false
        //false to sart the animation after circle is displayed on the view
        
        var body: some View {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(colors: [
                            .blue,
                            .indigo,
                            .purple,
                            .customSalmonLight
                        ],startPoint: isAnimationGradient ? .topLeading : .bottomLeading,
                                       endPoint: isAnimationGradient ? .bottomTrailing : .topTrailing
                        )
                    )
                    .onAppear {
                        withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: true)) {
                            isAnimationGradient.toggle()
                        }
                    }
                MotionAnimationView()
            } .frame(width: 270, height: 270)
        }
    }
    #Preview {
        CustomCircleView()
    }
