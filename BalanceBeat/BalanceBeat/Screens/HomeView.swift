//
//  HomeView.swift
//  BalanceBeat
//
//  Created by Magdalena Samuel on 1/17/24.
//

import SwiftUI


struct TextOption {
    let title: String
    let body: String
}

struct HomeView: View {
    // MARK: - PROPERTIES
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    
    @State private var imageNumber: Int = 1
    @State private var imageOffset: CGSize = .zero
    @State private var randomNumber: Int = 1
    @State private var hasChangedImageOption = false
    @State private var currentTextIndex: Int = 0
    
    @State private var textOption: TextOption = TextOption(
        title: "Routine.",
        body: """
        Wake up with intention and structure your time with a start and end for each task.\n Even if it's imperfect, transition to another task when the time is up.\n Create harmony of growth  🌱.
        """
    )
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    let textOptions = [
        TextOption(
            title: "Workout.",
            body: """
            Elevate your workout to unlock the limitless possibilities within you. As you build physical strength, you're also cultivating the energy and mindset needed to think outside the box. Embrace the challenge, channel your inner strength, and conquer new horizons with every rep. You've got the power within to achieve greatness !
            """
        ),
        TextOption(
            title: "Fast.",
            body: """
            Fasting boosts mental clarity, concentration, and brain health, it gives an energy boost, and activates physical movement.
            """
        ),
        TextOption(
            title: "Focus.",
            body: """
            The time that leads to mastery is dependent on the intensity of our focus.
            """
        ),
        TextOption(
            title: "Routine.",
            body: """
        Wake up with intention and structure your task with a start and end time points.\nWhen the time is up transition to another task, even if it's imperfect.\n Create harmony of growth  🌱.
        """
        )
    ]
    
    // MARK: - FUNCTIONS
    func changeImageOption() {
        withAnimation(.easeOut(duration: 1)) {
            repeat {
                randomNumber = Int.random(in: 1...3)
                print("Action: Random Number Generated = \(randomNumber)")
            } while randomNumber == imageNumber
            
            imageNumber = randomNumber
            
        }
    }
    
    func changeText() {
        withAnimation(.easeOut(duration: 0.5)) {
            textOption = textOptions[currentTextIndex % textOptions.count]
            currentTextIndex += 1
        }
        
    }
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.2)
                    .blur(radius: 5)
                    .animation(.easeOut(duration: 1), value: isAnimating)
                
                Image("character-\(imageNumber)")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(.easeInOut(duration: 2).repeatForever(), value: isAnimating)
                    }
            
            Spacer()
            
            VStack {
                Text(textOption.title)
                    .font(.system(size: 50))
                    .fontWeight(.heavy)
                    .foregroundColor(.secondary)
                    .transition(.opacity)
                    .id(textOption.title)
                    .padding()
                
                Text(textOption.body)
                    .font(.system(size: 17))
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    .padding()
                
                Image(systemName: "arrow.up")
                    .foregroundStyle(.secondary)
                    .padding(.top, 5)
            }
            .opacity(isAnimating ? 1 : 0)
            .offset(y: isAnimating ? 0 : -40)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        withAnimation(.easeOut(duration: 0.5)) {
                            if !hasChangedImageOption {
                                imageOffset = gesture.translation
                                   
                                changeText()
                                changeImageOption()
                                hasChangedImageOption = true
                            }
                        }
                    }
                    .onEnded { _ in
                        // Reset the flag when the gesture ends
                        hasChangedImageOption = false
                    }
                
            )
            //.animation(.easeOut(duration: 1), value: imageOffset)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    isOnboardingViewActive = true
                    playSound(sound: "success", type: "m4a")
                }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            } //: BUTTON
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                // introduce a delay of 0.5 seconds before setting isAnimating to true.
                isAnimating = true
            }
        }
    }
}

// Preview code remains unchanged

#Preview {
    HomeView()
}
