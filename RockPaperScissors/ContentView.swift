//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Ibukunoluwa Soyebo on 21/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var array_options = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var computer_selection = Int.random(in: 0..<3)
    @State private var is_To_Win = Bool.random()
    @State private var isPresentingAlert = false
    @State private var isCorrect = false
    @State private var score = 0
    @State private var game_count = 0
    
    var hmmArray: [String]{
        
        return array_options.filter({
            $0 != array_options[computer_selection]
        })
    }
    
    var body: some View {
        VStack{
            Text("Computer Chose \(array_options[computer_selection])")
                .font(.title)
            Text("Guess \(is_To_Win ? "Right ✅":"Wrong ❌")")
                .padding()
                .font(.title3)
            
            
            
            ForEach(0..<hmmArray.count){ number in
                Button(action: {
                    isCorrect = determineRightAnswer() == hmmArray[number]
                    isPresentingAlert = true
                }, label: {
                    Text(hmmArray[number]).padding()
                
                })
            }
            
            Text("Score: \(score)/10")
                .padding()
        }.alert(isPresented: $isPresentingAlert, content: {
            Alert(title: Text(isCorrect ? "Correct":"Wrong"), message: Text("You \(isCorrect ? "Scored":"Lost") a point"), dismissButton: .default(Text("Ok")){
                score = isCorrect ? score + 1 : score - 1
                game_count += 1
                array_options.shuffle()
                is_To_Win = Bool.random()
            })
        })
    }
    
    func determineRightAnswer() -> String{
        switch array_options[computer_selection] {
        case "Rock":
            return is_To_Win ? "Paper" : "Scissors"
        case "Paper":
            return is_To_Win ? "Scissors" : "Rock"
        case "Scissors":
            return is_To_Win ? "Rock" : "Paper"
        default:
            return ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
