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
    
    @State private var alert_title = ""
    @State private var alert_message = ""

    
    @State private var isCorrect = false
    @State private var score = 0
    @State private var game_count = 0
    
    var hmmArray: [String]{
        return array_options.filter({
            $0 != array_options[computer_selection]
        })
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Round \(game_count + 1)")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.white)
                Text("Computer Chose \(array_options[computer_selection])")
                    .font(.title)
                    .foregroundColor(.white)

                Text("Guess \(is_To_Win ? "Right ✅":"Wrong ❌")")
                    .padding()
                    .font(.title3)
                    .foregroundColor(.white)

                
                
                
                ForEach(0..<hmmArray.count){ number in
                    Button(action: {
                        game_count += 1
                        isCorrect = determineRightAnswer() == hmmArray[number]
                        presentAlertLogic()
                    }, label: {
                        Text(hmmArray[number]).padding()
                    
                    })
                    .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                    .foregroundColor(.white)
                }
                
                Text("Score: \(score)/10")
                    .padding()
                    .foregroundColor(.white)

            }
            
        }.alert(isPresented: $isPresentingAlert, content: {
            Alert(title: Text(alert_title), message: Text(alert_message), dismissButton: .default(Text("Ok")){
                score = isCorrect ? score + 1 : score - 1
                array_options.shuffle()
                is_To_Win = Bool.random()
            })
        })
        
    }
    
    func presentAlertLogic(){
        if game_count == 10{
            alert_title = "Game's Done"
            alert_message = "Reset Game?"
        }else{
            alert_title = isCorrect ? "Correct":"Wrong"
            alert_message = "You \(isCorrect ? "Scored":"Lost") a point"
        }
        isPresentingAlert = true
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
