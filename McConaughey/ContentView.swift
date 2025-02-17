//
//  ContentView.swift
//  McConaughey
//
//  Created by Noah McGuire on 2/17/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var stepperValue = 1
    @State private var audioPlayer: AVAudioPlayer!
    var body: some View {
        VStack {
            Text("How is Matt?")
                .font(.largeTitle)
                .fontWeight(.black)
            Image("matt")
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 30))
                .shadow(radius: 10)
            
            Spacer()
            
            Stepper("How Alright is Matt?", value: $stepperValue, in: 1...10)
            Text(String(stepperValue))
                .font(.largeTitle)
            
            Spacer()
            
            Button("Tell Me!") {
                playSound(soundName:"alright")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    func playSound(soundName: String) {
        if audioPlayer != nil && audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.numberOfLoops = stepperValue - 1
            audioPlayer.play()
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
