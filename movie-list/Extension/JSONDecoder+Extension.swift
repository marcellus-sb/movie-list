//
//  JSONDecoder+Extension.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 20/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import Alamofire

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}

extension JSONDecoder {
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        if let err = response.error {
            return .failure(err)
        }
        
        guard let responseData = response.data else {
            return .failure(BackendError.objectSerialization(reason:
                "Did not get data in response"))
        }
        
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            return .failure(error)
        }
    }
}
