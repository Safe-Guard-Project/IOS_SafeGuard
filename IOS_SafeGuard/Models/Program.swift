//
//  Program.swift
//  IOS_SafeGuard
//
//  Created by abir on 27/11/2023.
//

import Foundation
struct Program: Identifiable {
    let id = UUID()
    let image: String
    let Titre: String
    let descriptionProgramme: String
    
}
let programs = [
    Program(image:"Intro",Titre:"Tsunami",descriptionProgramme:"aman ekhdem"),
    Program(image:"Intro",Titre:"Tsunami",descriptionProgramme:"aman ekhdem"),
    Program(image:"Intro",Titre:"Tsunami",descriptionProgramme:"aman ekhdem"),

]
