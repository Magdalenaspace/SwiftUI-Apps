//
//  CardView.swift
//  SwiftUIExplorer
//
//  Created by Magdalena Samuel on 1/15/24.
//

import SwiftUI

struct CardView: View {
    // MARK: - PROPERTIES
    
    @State private var imageNumber: Int = 1
    @State private var randomNumber: Int = 1
    @State private var isShowingSheet: Bool = false
    
    // MARK: - FUNCTIONS
    
    func randomImage() {
      print("Status: Old Image Number = \(imageNumber)")
      
      repeat {
        randomNumber = Int.random(in: 1...5)
        print("Action: Random Number Generated = \(randomNumber)")
      } while randomNumber == imageNumber
      
      imageNumber = randomNumber
      
      print("Result: New Image Number = \(imageNumber)")

    }
    
    var body: some View {
        ZStack {
            CustomBackgroundView()
            VStack {
                // MARK: - Header
                VStack(alignment: .leading) {
                    HStack {
                        Text("Discover Beautiful UI")
                            .fontWeight(.black)
                            .font(.system(size: 32))
                            .padding(.top)
                            .foregroundStyle(
                              LinearGradient(
                                colors: [
                                  .customGrayLight,
                                  .customGrayMedium],
                                startPoint: .top,
                                endPoint: .bottom)
                            )
                        
                        Spacer()
                        
                        Button {
                          print("The button was pressed.")
                            isShowingSheet.toggle()
                        } label: {
                            CustomButtonView()
                        }
                        .sheet(isPresented: $isShowingSheet, content: {
                            SettingView()
                                .presentationDragIndicator(.visible)
                                .presentationDetents([.medium,.large])
                        })
                       
                        
                    }
                
                    Text("Engage in an interactive journey through stunning UI designs.")
                        .multilineTextAlignment(.leading)
                        .italic()
                        .foregroundColor(.customGrayMedium)
                } //: HEADER
                .padding(.horizontal, 30)
                
                // MARK: - Content
                ZStack {
                    CustomCircleView()
                    
                    Image("image-\(imageNumber)")
                        .resizable()
                        .scaledToFit()
                        .animation(.easeOut(duration: 2), value: imageNumber)
                }
                
                // MARK: -Footer
                Button {
                  // ACTION: Generate a random number
                  
                  randomImage()
                } label: {
                  Text("Explore More")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundStyle(
                      LinearGradient(
                        colors: [
                            .customGreenLight,
                            .customGreenMedium],
                        startPoint: .top,
                        endPoint: .bottom
                      )
                    )
                    .shadow(color: .black.opacity(0.25), radius: 0.25, x: 1, y: 2)
                }
                .padding(.vertical)
                .padding(.horizontal, 30)
                .buttonStyle(GradientButton())
            }
        }.frame(width: 330, height: 570)
    }
}

#Preview {
    CardView()
}
