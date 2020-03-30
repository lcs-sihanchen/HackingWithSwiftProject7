//
//  Petition.swift
//  HackingWithSwiftProject7
//
//  Created by Chen, Sihan on 2020-03-30.
//  Copyright © 2020 Chen, Sihan. All rights reserved.
//

import Foundation

struct Petition: Codable {
   // Two Strings and a int
   // The structure itself will conform to Codable
   var title: String
   var body: String
   var signatureCount: Int
}
