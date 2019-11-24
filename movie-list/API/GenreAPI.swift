//
//  GenreAPI.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 20/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import Alamofire

typealias GenreAPILoadCompletion = (GenresList?, Error?) -> Void

final class GenreAPI {
    func loadGenres(completion: @escaping GenreAPILoadCompletion) {
        
        let params: [String: String] = ["api_key": "1f54bd990f1cdfb230adb312546d765d",
                                        "language": "pt-BR"]
        
        Alamofire.request("https://api.themoviedb.org/3/genre/movie/list", method: .get, parameters: params)
            .responseData { response in
                let result: Result<GenresList> = JSONDecoder().decodeResponse(from: response)
                
                switch result {
                case .success(let result):
                    completion(result, nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
