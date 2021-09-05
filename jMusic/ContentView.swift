//
//  ContentView.swift
//  jMusic
//
//  Created by Jobin Jose on 5/9/21.
//

import SwiftUI
import AVFoundation


var player = AVAudioPlayer()
func prepareTrack(){
    let fileManager = FileManager.default
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    do {
        let directoryContents = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
        let mp3Files = directoryContents.filter{ $0.pathExtension == "mp3" }
        print("mp3 urls:",mp3Files)
        let mp3FileNames = mp3Files.map{ $0.deletingPathExtension().lastPathComponent }
        print("mp3 list:", mp3FileNames)
        
        player = try AVAudioPlayer(contentsOf: mp3Files[0], fileTypeHint: "mp3")
        player.prepareToPlay()
        
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
        print("Playback OK")
        try AVAudioSession.sharedInstance().setActive(true)
        print("Session is Active")
        
    } catch {
        print("Error \(error.localizedDescription)")
    }

}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
        Button("Start") {
            prepareTrack()
            player.play()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
