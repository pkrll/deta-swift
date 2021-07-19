//
//  File.swift
//  
//
//  Created by Ardalan Samimi on 2021-07-19.
//

import Foundation

public struct Put {
    
    struct Request<Item: Encodable>: Encodable {
        let items: [Item]
    }
    
    public struct Response<Item: Decodable>: Decodable {
        public struct Processed: Decodable {
            public let items: [Item]
        }
        
        public struct Failed: Decodable {
            public let items: [Item]
        }
        
        public let processed: Processed?
        public let failed: Failed?
    }
}
