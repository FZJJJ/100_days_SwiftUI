//
//  Filemanager-Extension.swift
//  MeetUp
//
//  Created by FZJ on 2024/6/11.
//

import Foundation

extension FileManager {
    var getDocumentDirectory: URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
