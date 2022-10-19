//
//  ContentView.swift
//  XO_games
//
//  Created by dat on 29/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["","","","","","","","",""]
    @State private var resultText = "XO GAME"
    @State private var gameEnded = false
    private var ranges = [(0..<3),(3..<6),(6..<9)]
    @State private var  playerScore = 0
    @State private var  AIScore = 0
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("BrownColor"), Color("BoardColor")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                Image("XOlogo")
                Text(resultText)
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .alert(resultText, isPresented: $gameEnded) {Button("Reset", role: .destructive, action: newGame)
                            
                    }
                HStack {
                    Spacer()
                    VStack {
                        Text("Player")
                            .font(.headline)
                            .foregroundColor(Color.black)
                        
                        Text(String(playerScore))
                            .font(.largeTitle)
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                    VStack {
                        Text("CPU")
                            .font(.headline)
                            .foregroundColor(Color.black)
                        Text(String(AIScore))
                            .font(.largeTitle)
//                            .foregroundColor(Color.black).onAppear(perform: {
//                                playSound(sound: "drum-music", type: "mp3")
//                              })
                        
                    }
                    Spacer()
                }
                ForEach(ranges, id: \.self) { range in
                    HStack {
                        ForEach(range, id: \.self) { i in
                            XOButton(character: $moves[i])
                                .simultaneousGesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            print("Tap: \(i)")
                                            playerTap(index: i)
                                                                                }
                                )
                        }
                    }
                }
                Spacer()
                
                Button("New Game",action: newGame)
            }
        }
    }
    func newGame(){
        resultText = "XO game"
        moves = ["","","","","","","","",""]
        addScore()
        
    }
    func playerTap(index: Int) {
        if moves[index] == "" {
            moves[index] = "X"
            playSound(sound: "click", type: "mp3")
            botMove()


        }
        for character in ["X", "O"] {
            if checkWinner(list: moves, character: character) {
                resultText = "\(character) has won!"
                gameEnded = true
                playSound(sound: "winning", type: "mp3")
                break
            }
        }
    }

    func botMove() {
        var availableMoves: [Int] = []
        var motion = 0

        // Check the available moves left
        for move in moves {
            if move == "" {
                availableMoves.append(motion)
            }
            motion += 1
        }

        // Make sure there are moves left before bot moves
        if availableMoves.count != 0 {
            moves[availableMoves.randomElement()!] = "O"
        }

        // Logging
        print(availableMoves)
    }
    func checkWinner(list: [String], character: String) -> Bool {
        let winningSequences = [
            // Horizontal rows
            [ 0, 1, 2 ], [ 3, 4, 5 ], [ 6, 7, 8 ],
            // Diagonals
            [ 0, 4, 8 ], [ 2, 4, 6 ],
            // Vertical rows
            [ 0, 3, 6 ], [ 1, 4, 7 ], [ 2, 5, 8 ],
        ]
        
        for sequence in winningSequences {
            var score = 0
            
            for match in sequence {
                if list[match] == character {
                    score += 1
                    
                    if score == 3 {
                        print("\(character) has won!")
                        return true
                    }
                }
            }
        }
        return false
    }
    func addScore(){
        if resultText == "O has won!"{
            AIScore += 1
        } else {
            playerScore += 1
        }
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
