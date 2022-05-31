//
//  AllNotesDataModel.swift
//  DripNote
//
//  Created by Bansi Mamtora on 01/06/22.
//

import Foundation
import RealmSwift

class AllNotesDataModel: Object {
    
    @Persisted var noteId: UUID
    @Persisted var title: String
    @Persisted var detail: String
    @Persisted var favorite: Bool
    
    convenience init(noteId: UUID,title: String, detail: String,favorite: Bool) {
        self.init()
        self.noteId = noteId
        self.title = title
        self.detail = detail
        self.favorite = favorite
    }
}
