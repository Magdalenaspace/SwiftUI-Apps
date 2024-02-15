//
//  OnboardingView.swift
//  BalanceBeat
//
//  Created by Magdalena Samuel on 1/17/24.
//

import SwiftUI

struct OnboardingView: View {
    //will find and it will skip this initialization
    //if will not find identifizier will storea
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero //both height and width are 0 initialy
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Balance."
    @State private var textBody: String = """
    What if there is a way to balance the life, ensuring consistent achievement of all your tasks\n \n That could be the key to your motivation.
    """
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                // MARK: - HEADER
                Spacer()
                
                VStack {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                        //We use the ID method to tell Swiftui that a view is no longer the same view,, as string change is not a view change-> After the change as a totally new view
                    
                    Text(textBody)
                        .font(.system(size: 17))
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                    
                } //: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                // MARK: - CENTER
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    // animate the opposite
                                  .offset(x: imageOffset.width * -1)
                                  .blur(radius: abs(imageOffset.width / 5))
                                  .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-2")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0) //moves the wanted direction horisontally
                        .rotationEffect(.degrees(Double(imageOffset.width / 20))) // angle rotation
                        .gesture(
                            DragGesture()
                            // I need character to change  and bring routine
                                .onChanged { gesture in
                                    // abs number og the given num, when we drag it goes negative so we stop at 150 point
                                    if abs(imageOffset.width) <= 150 {
                                        //holds the info of drag gesture
                                        imageOffset = gesture.translation
                                        
                                        //animates text
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0 //
                                            textTitle = "Breath."
                                            textBody = """
                                Life in every breath.\n  A happy life is within you, so cleanse your soul and let go, make a new space for your dream.
                                """
                                            
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    //get back
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                        textBody = """
                           True fulfilment comes when you share your successes and witness the growth of others alongside you.
                        """
                                    }
                                }
                            //goes back smoothly
                        ) //: GESTURE
                        .animation(.easeOut(duration: 1), value: imageOffset)
                } //: CENTER
                .overlay(
                    HStack {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                    }.animation(.easeOut(duration: 1).delay(1), value: isAnimating)
                        .frame(width: 50, height: 50)
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .foregroundStyle(.secondary)
                        .offset(y: 53)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    //every time user changes the opacity goes 0, look in animatin cenet
                        .opacity(indicatorOpacity)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
                Spacer()
                
                // MARK: - FOOTER
                
                ZStack {
                    // PARTS OF THE CUSTOM BUTTON
                    
                    // 1. BACKGROUND (STATIC)
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. CALL-TO-ACTION (STATIC)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // 3. CAPSULE (DYNAMIC WIDTH)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorPink"))
                        //change the whole color
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    
                    // 4. CIRCLE (DRAGGABLE)
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorPink"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            //start/ end -> 2 states
                            DragGesture()
                                .onChanged { gesture in
                                    //prevent outside drag
                                    if gesture.translation.width > 0 &&
                                        buttonOffset <= buttonWidth - 80 {
                                        //capture the action
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        ) //: GESTURE
                        
                        Spacer()
                    } //: HSTACK
                } //: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            } //: VSTACK
        } //: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
        //status bar apearance
        .preferredColorScheme(.dark)
    }
}

#Preview {
    OnboardingView()
}
