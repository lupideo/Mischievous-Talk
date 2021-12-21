//
//  MischievousTalkEntry.swift
//  MischievousTalk
//
//  Created by Lisbeth Bispo on 07/09/21.
//

import Foundation
import UIKit

class MischievousTalkEntry {
    var number = 0
    var verb = ""
    var adjective = ""
    var noun = ""
    var image = UIImage(named: "talk-talk_dirty")
    var talk = MischievousTalks.Talk.dirty
    var whistle = ""
    
    init() {
        whistle = MischievousTalks.whistleFor(talk: talk)
    }
    
    func isValid() -> Bool {
        return !(verb.isEmpty && adjective.isEmpty && noun.isEmpty)
    }
}

extension MischievousTalkEntry: CustomStringConvertible {
    var description: String {
        return whistle.replacingOccurrences(of: "<noun>", with: noun)
            .replacingOccurrences(of: "<verb>", with: verb)
            .replacingOccurrences(of: "<number>", with: String(number))
            .replacingOccurrences(of: "<adjective>", with: adjective)
    }
}
