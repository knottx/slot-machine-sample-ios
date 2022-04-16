//
//  Extensions.swift
//  Slot Machine
//
//  Created by Visarut Tippun on 15/4/22.
//

import SwiftUI

extension Color {
    static let colorPink = Color("ColorPink")
    static let colorPurple = Color("ColorPurple")
    static let colorYellow = Color("ColorYellow")
    static let colorTransparentBlack = Color("ColorTransparentBlack")
}

extension Text {
    func scoreLabelStyle() -> Text {
        self
            .foregroundColor(.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
    
    func scoreNumberStyle() -> Text {
        self
            .foregroundColor(.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
}
