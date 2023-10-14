//
//  ContentView.swift
//  PANIK
//
//  Created by Pieter Yoshua Natanael on 05/10/23.
//

import SwiftUI
import AVFoundation

extension Color {
    static let airbnbPink = Color(red: 255/255, green: 90/255, blue: 95/255)
}

extension Font {
    static func airbnbFont(size: CGFloat) -> Font {
        return Font.custom("AvenirNext-Bold", size: size)
    }
}

struct ContentView: View {
    @State private var isPanicMode = false
    @State private var audioPlayer: AVAudioPlayer?
    
    let panicTexts = ["Maafkan saya, saya sedang mengalami serangan panik.", "Saya tidak sekarat, tetapi rasanya seperti itu. 🥲", "Excuse me, I am having a panic attack.", "I'm not dying, but it feels like it. 🥲"]
    @State private var currentPanicTextIndex = 0
    
    var body: some View {
        VStack {
            if isPanicMode {
                Spacer() // Push to the top
                            
                            HStack {
                                Spacer(minLength: 20) // Push to the left
                                Text(panicTexts[currentPanicTextIndex])
                                    .font(Font.airbnbFont(size: 42))
                                    .foregroundColor(.airbnbPink)
                                    .padding()
                                    .multilineTextAlignment(.center)
                                Spacer(minLength: 20) // Push to the right
                            }
                            
                            Spacer() // Push to the bottom
                
                Button(action: stopPanic) {
                    Text("Selesai")
                        .font(Font.airbnbFont(size: 28))
                        .foregroundColor(.white)
                        
                        .padding()
                        .background(Color.airbnbPink)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(1.9), radius: 3, x: 0, y: 5) // Adding shadow
                }
                .padding()
            } else {
                Button(action: startPanic) {
                    ZStack {
                        Circle()
                                   .fill(Color.airbnbPink)
                                   .frame(width: 250, height: 250)
                                   .shadow(color: Color.black.opacity(1.9), radius: 3, x: 0, y: 5) // Adding shadow
                               
                               Text("Panik")
                                   .font(Font.airbnbFont(size: 48))
                                   .foregroundColor(.white)                    }
                }
                .padding()
            }
        }
        .onAppear {
            loadAudio()
            startTextCycleTimer()
        }
    }
    
    func loadAudio() {
        if let audioFilePath = Bundle.main.path(forResource: "music", ofType: "mp3") {
            let audioFileUrl = URL(fileURLWithPath: audioFilePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioFileUrl)
            } catch {
                print("Error loading audio file: \(error)")
            }
        }
    }
    
    func startPanic() {
        isPanicMode = true
        playAudio()
    }
    
    func stopPanic() {
        isPanicMode = false
        stopAudio()
    }
    
    func playAudio() {
        audioPlayer?.play()
    }
    
    func stopAudio() {
        audioPlayer?.stop()
    }
    
    func startTextCycleTimer() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            currentPanicTextIndex = (currentPanicTextIndex + 1) % panicTexts.count
        }
    }
}

struct PanicAttackAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


#Preview {
ContentView()
}



