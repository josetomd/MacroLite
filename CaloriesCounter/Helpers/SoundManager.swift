//
//  SoundManager.swift
//  CaloriesCounter
//
//  Created by Josset Garcia on 19-03-26.
//

import Foundation
import AVFoundation

enum SoundEffect: String {
    case success = "success"
    case error = "error"
    case delete = "delete"
}

class SoundManager: SoundProvider {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    private init() {}

    func play(sound: SoundEffect) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else {
            print("Error: Couldn't find the sound file \(sound.rawValue).mp3")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Error playing the sound: \(error.localizedDescription)")
        }
    }
}
