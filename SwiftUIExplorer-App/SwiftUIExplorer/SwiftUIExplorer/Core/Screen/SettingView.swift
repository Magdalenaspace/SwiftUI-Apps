//
//  SettingView.swift
//  SwiftUIExplorer
//
//  Created by Magdalena Samuel on 1/16/24.
//

import SwiftUI

struct SettingView:  View {
    // MARK: - PROPERTIES
    private let alternateAppIcons: [String] = [
      "AppIcon-MagnifyingGlass",
      "AppIcon-Map",
      "AppIcon-Mushroom",
      "AppIcon-Camera",
      "AppIcon-Backpack",
      "AppIcon-Campfire"
    ]
    
    var body: some View {
      List {
        // MARK: - SECTION: HEADER
        Section {
          HStack {
            Spacer()
            
            Image(systemName: "laurel.leading")
              .font(.system(size: 80, weight: .black))
            
            VStack {
              Text("SwiftUIExplorer")
                .font(.system(size: 19, weight: .black))
              
              Text("Learn and have fun")
                .fontWeight(.medium)
                
            }
            
            Image(systemName: "laurel.trailing")
              .font(.system(size: 80, weight: .black))
            
            Spacer()
          }
          .foregroundStyle(
            LinearGradient(
              colors: [
                .customGreenLight,
                .customGreenMedium,
                .customGreenDark
              ],
              startPoint: .top,
              endPoint: .bottom
            )
          )
          .padding(.top, 8)
          
          VStack(spacing: 8) {
            Text("Where can you find \na grate learning journey?")
              .font(.title2)
              .fontWeight(.heavy)
            
            Text("The SwiftUI Explorer is not just an app that's fun to look at, it becomes even more enjoyable when you dive into programming with it. \nDesigned to showcase the possibilities of creating both simple and fun user interfaces. \nExplore and and discover where could you implement some of it in your own projects.")
              .font(.footnote)
              .italic()
            
            Text("It's time to explore the creative possibilities with SwiftUI Explorer.")
              .fontWeight(.heavy)
              .foregroundColor(.customGreenMedium)
          }
          .multilineTextAlignment(.center)
          .padding(.bottom, 16)
          .frame(maxWidth: .infinity)
        } //: HEADER
        .listRowSeparator(.hidden)
        
        // MARK: - SECTION: ICONOGRAPHY, LABEL, LINK
        
        Section(header: Text("Alternate Icons")) {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
              ForEach(alternateAppIcons.indices, id: \.self) { item in
                Button {
                  print("Icon \(alternateAppIcons[item]) was pressed.")
                  
                  UIApplication.shared.setAlternateIconName(alternateAppIcons[item]) { error in
                    if error != nil {
                      print("Failed request to update the app's icon: \(String(describing: error?.localizedDescription))")
                    } else {
                        print("Success! You have changed the app's icon to \(alternateAppIcons[item])")
                    }
                  }
                } label: {
                  Image("\(alternateAppIcons[item])-Preview")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(16)
                }
                .buttonStyle(.borderless) //for Lists
              }
            }
          } //: SCROLL VIEW
          .padding(.top, 12)
          
          Text("Choose your favourite app icon from the collection above.")
            .frame(minWidth: 0, maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
            .font(.footnote)
            .padding(.bottom, 12)
        } //: SECTION
        .listRowSeparator(.hidden)
        
        // MARK: - SECTION: ABOUT
        
        Section(
          header: Text("ABOUT THE APP"),
          footer: HStack {
            Spacer()
            Text(" © 2023 Magdalena Samuel")
            Spacer()
          }
            .padding(.vertical, 8)
        ) {
          // 1. Basic Labeled Content
          // LabeledContent("Application", value: "UIExplorer")
          
          // 2. Advanced Labeled Content
          
          CustomListRowView(rowLabel: "Application", rowIcon: "apps.iphone", rowContent: "SwiftUIExplorer", rowTintColor: .blue)
          
          CustomListRowView(rowLabel: "Compatibility", rowIcon: "info.circle", rowContent: "iOS, iPadOS", rowTintColor: .red)
          
          CustomListRowView(rowLabel: "Technology", rowIcon: "swift", rowContent: "Swift", rowTintColor: .orange)
          
          CustomListRowView(rowLabel: "Version", rowIcon: "gear", rowContent: "1.0", rowTintColor: .purple)
          
          CustomListRowView(rowLabel: "Developer", rowIcon: "ellipsis.curlybraces", rowContent: "Magdalena Samuel", rowTintColor: .mint)
          
          CustomListRowView(rowLabel: "Design Tool", rowIcon: "paintpalette", rowContent: "SwiftUI", rowTintColor: .pink)
          
          CustomListRowView(rowLabel: "Website", rowIcon: "globe", rowTintColor: .indigo, rowLinkLabel: "Magdalena's Portfolio", rowLinkDestination: "https://github.com/Magdalenaspace")
          
        } //: SECTION
      } //: LIST
    }
  }

#Preview {
    SettingView()
}
