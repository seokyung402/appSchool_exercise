//
//  ContentView.swift
//  OXQuiz
//
//  Created by 이서경 on 4/15/24.
//

import SwiftUI

struct ContentView: View {
    @State var number1: Int = Int.random(in: 1...10)
    @State var number2: Int = Int.random(in: 1...10)
    @State var resultNumber: Int = Int.random(in: 1...100)
    
    @State var countCorrect: Int = 0
    @State var countWrong: Int = 0
    
    //ui 구성
    var body: some View {
        VStack(spacing: 120) {
            Text("다음 수식은 맞을까요?")
            Text("\(number1) x \(number2) = \(resultNumber)")
            
            HStack(spacing: 50) {
                Button(action: selectCorrect, label: {
                    Image(systemName: "checkmark.diamond.fill")
                    Text("맞음")
                }).foregroundColor(.green)

                Button(action: selectWrong, label: {
                    Image(systemName: "xmark.diamond")
                    Text("틀림")
                }).foregroundColor(.red)
            }.fontWeight(.bold)
            
            HStack(spacing: 50) {
                Text("\(countCorrect)개 맞춤")
                Text("\(countWrong)개 틀림")
            }
            
            Button(action: reloadGame, label: {
                Text("카운트 초기화")
            }).foregroundColor(.blue)
            
        }.font(.largeTitle)
        
    }
    
    // 초기화
    func reloadGame() {
        countWrong = 0
        countCorrect = 0
        newGame()
        
    }
    
    // 정답
    func selectCorrect() {
        if (number1*number2) == resultNumber {
            countCorrect += 1
        } else {
            countWrong += 1
        }
        newGame()
    }
    
    // 오답
    func selectWrong() {
        if (number1*number2) != resultNumber {
            countCorrect += 1
        } else {
            countWrong += 1
        }
        newGame()
    }
    
    // 문제 초기화
    func newGame() {
        number1 = Int.random(in: 1...10)
        number2 = Int.random(in: 1...10)
        if Bool.random() {
            resultNumber = Int.random(in: 1...100)
        } else { resultNumber = number1 * number2 }
    }
}


#Preview {
    ContentView()
}
