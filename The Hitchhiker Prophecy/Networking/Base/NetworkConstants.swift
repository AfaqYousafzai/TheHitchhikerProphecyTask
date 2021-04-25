//
//  NetworkConstants.swift
//  The Hitchhiker Prophecy
//
//  Created by Mohamed Matloub on 6/10/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import Foundation
import CryptoKit

enum NetworkConstants {
    static let baseUrl = "https://gateway.marvel.com"
    static let publicKey = "ab5e32a7b46fa94bcab73690edc965ed" // TODO: Add your marvel keys
    static let privateKey = "40b485439ea7e55a8aec633018335846c9fb45c3" // TODO: Add your marvel keys
  
    // static function for calculating the hash value by using time stamp, private key and public key
    static func hashValue(ts:String) -> String {
        let inputString = "\(ts)\(NetworkConstants.privateKey)\(NetworkConstants.publicKey)"
        let digest = Insecure.MD5.hash(data: inputString.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
