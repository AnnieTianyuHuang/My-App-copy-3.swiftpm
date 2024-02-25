import SwiftUI
import AVFoundation

class AudioPlayerManager: ObservableObject {
    @Published var player: AVAudioPlayer?
    
    init() {
        guard let path = Bundle.main.path(forResource: "MyOriginalMusic", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category. \(error)")
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
        } catch {
            print("Error loading audio file: \(error)")
        }
    }
    
    func playPause() {
        if player?.isPlaying == true {
            player?.pause()
        } else {
            player?.play()
        }
    }
    
    // To make sure the player gets deinitialized correctly
    deinit {
        player?.stop()
    }
}
