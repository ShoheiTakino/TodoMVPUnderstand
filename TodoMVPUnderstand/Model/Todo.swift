//
//  Todo.swift
//  TodoMVPUnderstand
//
//  Created by 滝野翔平 on 2022/08/23.
//

import Foundation

enum TodoValidation {
    
    case blank
    case overMaximumCharacters
    var alert: String {
        switch self {
        case .blank: return "文字を入力してください"
        case .overMaximumCharacters: return "20文字以内にしてください"
        }
    }
}

final class Todo: NSObject, NSCoding {
    
    var id: String
    var todo: String
    
    init(todo: String) {
        self.id = UUID.init().uuidString
        self.todo = todo
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(todo, forKey: "todo")
    }
    
    init?(coder: NSCoder) {
        id = (coder.decodeObject(forKey: "id") as? String) ?? ""
        todo = (coder.decodeObject(forKey: "todo") as? String) ?? ""
    }
    
}
