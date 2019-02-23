//
//  JSONDecoder-Remote.swift
//  FriendFace
//
//  Created by Bharath  Raj kumar on 28/01/19.
//  Copyright © 2019 Bharath Raj Kumar. All rights reserved.
//

import Foundation


extension JSONDecoder
{
    func decode<T: Decodable>(_ type: T.Type, fromURL url: String, completion: @escaping (T) -> Void)
    {
        guard let url = URL(string: url) else
        {
            fatalError("Invalid URL")
        }
        DispatchQueue.global().async {
            do
            {
                
                let data = try Data(contentsOf: url)
                let downloadedData = try self.decode(type, from: data)
                DispatchQueue.main.async {
                    completion(downloadedData)
                }
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
        
        
    }
}
