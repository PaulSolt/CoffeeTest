//
//  ContentView.swift
//  CoffeeTest
//
//  Created by Paul Solt on 6/4/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

// Worked with Kyle + Dave Abrahams

// Create two vertical stack views (brew stack) (check stack)

// ZStack (align q)
//  ZStack (align r)
//     ZStack (align s)


import SwiftUI
extension HorizontalAlignment {
    private enum Q : AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> Length
        {
            context[HorizontalAlignment.center]
        }
    }
    static let q = HorizontalAlignment(Q.self)
    static let r = HorizontalAlignment(Q.self)
    static let s = HorizontalAlignment(Q.self)
}

struct CoffeeStep: View {
    var text = "Bloom"
    var symbol = "1"
    var isSelected = false
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .q, vertical: .bottom)) {
            if isSelected {
                ZStack {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 130, height: 130)
//                        .padding(.bottom, -20)
                    Rectangle()
                        .alignmentGuide(HorizontalAlignment.q) { $0[HorizontalAlignment.center]
                        }
                    .frame(width: 50, height: 50)
                }
            }
            HStack {
                Text(text)
                    .alignmentGuide(HorizontalAlignment.q) { $0[HorizontalAlignment.center]
                    }
                ZStack {
                    Circle()
                        .frame(width: 22, height: 22)
                    Text(symbol)
                        .bold()
                        .color(.white)
                }
                
            }
        }
    }
}

struct ContentView : View {
    var body: some View {
        HStack() {
            
            Spacer()
            VStack(alignment: .trailing) {
                CoffeeStep(text: "Bloom", symbol: "1", isSelected:  true)
                
                
                CoffeeStep(text: "Pour", symbol: "2", isSelected: false)
                
                CoffeeStep(text: "Drain", symbol: "3")
                Spacer()
                }
                .padding(.top, 40)
                .padding(.trailing, 16)
            
            
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
