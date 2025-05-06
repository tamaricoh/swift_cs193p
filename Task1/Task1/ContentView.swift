//
//  ContentView.swift
//  Task1
//
//  Created by Tamar Cohen on 29/04/2025.
// 

import SwiftUI

struct ContentView: View {

    private static let heartEmojis: [String] = ["❤️", "🧡", "💛", "💚", "💙", "💜"]
    private static let girlyEmojis: [String] =  ["💄", "💅", "👠", "🎀", "👡", "🌸", "💍"]
    private static let pinkEmojis: [String] = ["💖", "🌸", "🎀", "🩷", "💐", "🛍️", "👚", "👛"]
    
    @State var emojis : [String] = []
    @State var color : Color = .accentColor

    let themesCount = 3
    let themes = [
        Theme(name: "Hearts", emojis: heartEmojis, image: "heart", color: .red),
        Theme(name: "Pink", emojis: pinkEmojis, image: "paintbrush.pointed", color: .pink),
        Theme(name: "Girly", emojis: girlyEmojis, image: "figure.stand.dress", color: .purple)
    ]
    
    var body: some View {
        Text("Memorize!").font(.largeTitle)
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            setTheme
            
        }
        .padding()
    }
    
    var setTheme : some View {
        HStack {
            ForEach(themes, id: \.name) { theme in
                Button(action: {
                    emojis = theme.emojiSet()
                    color = theme.color
                }) {
                    VStack {
                        Image(systemName: theme.image).imageScale(.large)
                        Text(theme.name).font(.system(size: 15))
                    }
                }
                .padding()
            }
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: CGFloat(100 - (emojis.count - 3) * 2)), spacing: 0)], spacing: 0) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(color)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    let base = RoundedRectangle(cornerRadius: 12)
    
    var body: some View {
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(isFaceUp ? 1:0)
            base.fill().opacity(isFaceUp ? 0:1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct Theme {
    let name: String
    let emojis: [String]
    let image: String
    let color: Color

    func emojiSet() -> [String] {
        let count = Int.random(in: 2...emojis.count)
        let selected = emojis.shuffled().prefix(count)
        return (selected + selected).shuffled()
    }
}

#Preview {
    ContentView()
}
