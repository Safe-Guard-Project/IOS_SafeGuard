//
//  CousViewModel.swift
//  IOS_SafeGuard
//
//  Created by abir on 28/11/2023.
//

import Foundation
class CousViewModel: ObservableObject {
    @Published var courses = Cours(_id: "ok" , type :"ok")
    @Published var comment = ""
    
    
    
    func postComment(){
        print(comment)
        comment = ""
    }
}
