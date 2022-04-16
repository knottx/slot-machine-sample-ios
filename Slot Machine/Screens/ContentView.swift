//
//  ContentView.swift
//  Slot Machine
//
//  Created by Visarut Tippun on 15/4/22.
//

import SwiftUI

enum Symbol: String, CaseIterable {
    case bell = "gfx-bell"
    case cherry = "gfx-cherry"
    case coin = "gfx-coin"
    case grape = "gfx-grape"
    case seven = "gfx-seven"
    case strawberry = "gfx-strawberry"
}

struct ContentView: View {
    
    let symbols: [Symbol] = Symbol.allCases
    
    @State private var highScore: Int = 0
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var reels: [Int] = [0, 1, 2]
    @State private var showingInfoView: Bool  = false
    
    func spinReels() {
        reels = reels.map { _ in Int.random(in: 0..<symbols.count) }
    }
    
    func checkWining() {
        if reels.dropFirst().allSatisfy({ $0 == reels.first }) {
            playerWins()
            
            if coins > highScore {
                newHighScore()
            }
        } else {
            playerLoses()
        }
    }
    
    func playerWins() {
        coins += betAmount * 10
    }
    
    func newHighScore() {
        highScore = coins
    }
    
    func playerLoses() {
        coins -= betAmount
    }
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [.colorPink, .colorPurple]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 5) {
                LogoView()
                
                Spacer()
                
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text(coins.description)
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    } //: HStack
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text(highScore.description)
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                    } //: HStack
                    .modifier(ScoreContainerModifier())
                } //: HStack
                
                VStack(alignment: .center, spacing: 0) {
                    ZStack {
                        ReelView()
                        Image(symbols[reels[0]].rawValue)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]].rawValue)
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]].rawValue)
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    Button {
                        self.spinReels()
                        self.checkWining()
                    } label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }

                } //: VStack
                .layoutPriority(2)
                
                Spacer()
                
                HStack {
                    HStack(alignment: .center, spacing: 10) {
                        Button {
                            print("Bet 20 coins")
                        } label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(0)
                            .modifier(CasinoChipsModifier())
                    } //: HStack
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(1)
                            .modifier(CasinoChipsModifier())
                        
                        Button {
                            print("Bet 10 coins")
                        } label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(.yellow)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                    } //: HStack
                } //: HStack
                
            } //: VStack
            .overlay(alignment: .topLeading) {
                Button {
                    print("Reset")
                } label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                .modifier(ButtonModifier())
            }
            
            .overlay(alignment: .topTrailing) {
                Button {
                    self.showingInfoView = true
                } label: {
                    Image(systemName: "info.circle")
                }
                .modifier(ButtonModifier())
            }
            .padding()
            .frame(maxWidth: 720)
            
        } //: ZStack
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
