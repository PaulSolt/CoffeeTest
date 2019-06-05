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
    private enum Center : AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> Length {
            context[HorizontalAlignment.center]
        }
    }
    
    private enum Trailing : AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> Length {
            context[HorizontalAlignment.trailing]
        }
    }
    
    static let highlightCenter = HorizontalAlignment(Center.self)
    static let highlightTrailing = HorizontalAlignment(Trailing.self)
    //    static let s = HorizontalAlignment(Center.self)
}

extension VerticalAlignment {
    private enum Step1Baseline : AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> Length {
            context[VerticalAlignment.firstTextBaseline]
        }
    }
    
    private enum Step2Baseline : AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> Length {
            context[VerticalAlignment.firstTextBaseline]
        }
    }
    
    private enum Step3Baseline : AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> Length {
            context[VerticalAlignment.firstTextBaseline]
        }
    }
    
    static let step1Baseline = VerticalAlignment(Step1Baseline.self)
    static let step2Baseline = VerticalAlignment(Step2Baseline.self)
    static let step3Baseline = VerticalAlignment(Step3Baseline.self)
}

struct StepHighlight: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.orange)
                .frame(width: 130, height: 130)
                .alignmentGuide(HorizontalAlignment.highlightTrailing) {
                    return $0[HorizontalAlignment.trailing] }
            //                        .padding(.bottom, -20)
            Rectangle()
                .alignmentGuide(HorizontalAlignment.highlightCenter) { $0[HorizontalAlignment.center] }
                .frame(width: 50, height: 50)
        }
    }
}

struct StepIcon: View {
    var symbol: String
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 22, height: 22)
            
            Text(symbol)
                .bold()
                .color(.white)
        }
    }
    init(_ symbol: String) {
        self.symbol = symbol
    }
}

struct CoffeeStep: View {
    var text = "Bloom"
    var symbol = "1"
    var isSelected = false
    var body: some View {
        
        ZStack {
            ZStack(alignment: Alignment(horizontal: .highlightCenter, vertical: .bottom)) {
                
                if isSelected {
                    StepHighlight()
                }
                Text(text)
                //                    .alignmentGuide(HorizontalAlignment.q) { $0[HorizontalAlignment.center] }
            }
            ZStack(alignment: Alignment(horizontal: .highlightTrailing, vertical: .bottom)) {
                
                StepIcon(symbol)
                
            }
        }
    }
}

struct ContentView : View {
    @State var stepNumber: Int = 0
    
    func nextStep() {
        stepNumber += 1
        if stepNumber > 3 {
            stepNumber = 0
        }
    }
    
    var body: some View {
        VStack {
            Button(action: nextStep) {
                Text("Next")
            }
            HStack() {
                
                
                Spacer()
                
                ZStack(alignment: Alignment(horizontal: .highlightTrailing, vertical: .step1Baseline)) {
                    
                    ZStack(alignment: Alignment(horizontal: .highlightTrailing, vertical: .step2Baseline)) {

                        ZStack(alignment: Alignment(horizontal: .highlightTrailing, vertical: .step3Baseline)) {

                            VStack(alignment: .center, spacing: 12) {
                                
                                if stepNumber == 0 {
                                    StepHighlight()
                                        .padding(.bottom, -40)
                                }
                                Text("Bloom")
                                    .alignmentGuide(.step1Baseline) {
                                        // Gets the value after the layout pass
                                        $0[VerticalAlignment.firstTextBaseline]
                                }
                                if stepNumber == 1 {
                                    StepHighlight()
                                        .padding(.bottom, -40)
                                }
                                Text("Pour")
                                    .alignmentGuide(.step2Baseline) {
                                        // Gets the value after the layout pass
                                        $0[VerticalAlignment.firstTextBaseline]
                                }
                                if stepNumber == 2 {
                                    StepHighlight()
                                        .padding(.bottom, -40)
                                }
                                Text("Drain")
                                    .alignmentGuide(.step3Baseline) {
                                        // Gets the value after the layout pass
                                        $0[VerticalAlignment.firstTextBaseline]
                                }
                                // Fix alignment issue, otherwise center alignment collapses
                                if stepNumber == 3 {
                                    StepHighlight()
                                        .padding(.bottom, -40)
                                        .opacity(0)
                                }
                                
                            }
//                                .padding(.trailing, stepNumber == 3 ? 50 : 0)
                            StepIcon("3")
                        }
                        StepIcon("2")
                    }
                    StepIcon("1")
                }
                    .padding(.top, 40)
                    .padding(.trailing, 16)
                
                
                
                
                //                VStack(alignment: .trailing) {
                //                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                //
                //                        CoffeeStep(text: "Bloom", symbol: "1", isSelected:  true)
                //
                //
                //                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                //
                //                            CoffeeStep(text: "Pour", symbol: "2", isSelected: false)
                //
                //                            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                //
                //                                CoffeeStep(text: "Drain", symbol: "3")
                //                            }
                //                        }
                //                    }
                //
                //                    Spacer()
                //                    }
                //                    .padding(.top, 40)
                //                    .padding(.trailing, 16)
                //                .background(Color.blue)
                
                
            }
            Spacer()
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
