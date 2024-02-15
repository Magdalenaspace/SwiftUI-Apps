//
//  CustomListRowView.swift
//  SwiftUIExplorer
//
//  Created by Magdalena Samuel on 1/15/24.
//

import SwiftUI

struct CustomListRowView: View {
  // MARK: - PROPERTIES
  
  @State var rowLabel: String
  @State var rowIcon: String
  @State var rowContent: String? = nil
  @State var rowTintColor: Color
    
  //Link label, address
  @State var rowLinkLabel: String? = nil
  @State var rowLinkDestination: String? = nil
  
  var body: some View {
    LabeledContent {
      // Content
      if rowContent != nil {
        Text(rowContent!)
          .foregroundColor(.primary)
          .fontWeight(.semibold)
      } else if (rowLinkLabel != nil && rowLinkDestination != nil) {
        Link(rowLinkLabel!, destination: URL(string: rowLinkDestination!)!)
          .foregroundColor(.pink)
          .fontWeight(.semibold)
      } else {
          //EmtyContent
        EmptyView()
      }
    } label: {
      // Label
      HStack {
        ZStack {
          RoundedRectangle(cornerRadius: 8)
            .frame(width: 30, height: 30)
            .foregroundColor(rowTintColor)
          Image(systemName: rowIcon)
            .foregroundColor(.white)
            .fontWeight(.semibold)
        }
        
        Text(rowLabel)
      }
    }
  }
}


#Preview {
    //Default
    List {
        CustomListRowView( rowLabel: "Website",
                           rowIcon: "globe",
                           rowContent: "Magdalena",
                           rowTintColor: .pink,
                           rowLinkLabel:  nil,
                           rowLinkDestination: "Potfolio"
        )
    }
}
