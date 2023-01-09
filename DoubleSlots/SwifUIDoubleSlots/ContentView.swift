//
//  ContentView.swift
//  SwifUIDoubleSlots
//
//  Created by Soumya Deekonda on 8/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var symbols = ["apple", "cherry", "star"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    @State private var credits = 1000
    @State private var betAmount = 5
    var body: some View {
        
        ZStack{
            //Background
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            Rectangle()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                //Title
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.red)
                    Text("SwiftUI Slots")
                        .bold()
                        .foregroundColor(.white)
                    Image(systemName: "star.fill")
                        .foregroundColor(.red)
                    
                }.scaleEffect(2)
                Spacer()
                //Credits counter
                Text("Credits: " + String(credits))
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                Spacer()
                VStack {
                    //cards
                    HStack{
                        Spacer()
                        CardsView(background: $backgrounds[0], symbol: $symbols[numbers[0]])
                        CardsView(background: $backgrounds[1], symbol: $symbols[numbers[1]])
                        CardsView(background: $backgrounds[2], symbol: $symbols[numbers[2]])
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        CardsView(background: $backgrounds[3], symbol: $symbols[numbers[3]])
                        CardsView(background: $backgrounds[4], symbol: $symbols[numbers[4]])
                        CardsView(background: $backgrounds[5], symbol: $symbols[numbers[5]])
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        CardsView(background: $backgrounds[6], symbol: $symbols[numbers[6]])
                        CardsView(background: $backgrounds[7], symbol: $symbols[numbers[7]])
                        CardsView(background: $backgrounds[8], symbol: $symbols[numbers[8]])
                        Spacer()
                    }
                }
                Spacer()
                HStack (spacing: 20) {
                    //Button
                    
                    VStack{
                        Button {
                            //process a single spin
                            self.processResults()
                            
                        } label: {
                            Text("Spin").bold().foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink).cornerRadius(20)
                        }
                        Text("\(betAmount) credits").padding(.top, 10).font(.footnote)
                    }
                    //Button
                    VStack{
                        
                        Button {
                            //process a single spin
                            self.processResults(true)
                            
                        } label: {
                            Text("Max Spin").bold().foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink).cornerRadius(20)
                        }
                        Text("\(betAmount * 5) credits").padding(.top, 10).font(.footnote)
                    }
                }
                
                
                Spacer()
            }
        }
    }
    func processResults(_ isMax:Bool = false) {
        //set backgrounds black to white
        //or you can use map function
        self.backgrounds = self.backgrounds.map({ _ in
            Color.white
        })
        if isMax {
            //Spin all the cards
            self.numbers = self.numbers.map({ _ in
                Int.random(in: 0...self.symbols.count - 1)
            })
        }
        else {
            // Spin the middle row
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1)
        }
        //Check winnings
        processWin(isMax)
    }
    func processWin(_ isMax:Bool = false){
        var matches = 0
        if !isMax {
            //processing for single spin
            
            if isMatch(3, 4, 5) { matches += 1 }
        }
        else {
            //processing for max spin
            
            //top row
            if isMatch(0, 1, 2) { matches += 1}
            // Middle row
            if isMatch(3, 4, 5) { matches += 1}
            //bottom row
            if isMatch(6, 7, 8) { matches += 1}
            //diagonal top left to bottom right
            if isMatch(0, 4, 8) { matches += 1}
            
            //diagonal top right to bottom left
            if isMatch(2, 4, 6) { matches += 1}
        }
        //check matches and distribute credits
        if matches > 0
        {
            //At least 1 win
            self.credits += matches * betAmount * 2
        }
        else if !isMax {
            //0 wins, single spin
            self.credits -= betAmount
        }
        else {
            // 0 wins, max spin
            self.credits -= betAmount * 5
        }
    }
    func isMatch(_ index1:Int, _ index2:Int, _ index3:Int) -> Bool {
        if self.numbers[index1] == self.numbers[index2] && self.numbers[index2] == self.numbers[index3]
        {
            //or self.backgrounds = self.backgrounds.map{ _ in Color.green }
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green
            return true
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
