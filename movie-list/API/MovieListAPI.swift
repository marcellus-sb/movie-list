//
//  MovieAPI.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 20/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import Alamofire

typealias MovieListAPILoadCompletion = (MoviesList?, Error?) -> Void

final class MovieListAPI {
    func loadMovies(page: Int, completion: @escaping MovieListAPILoadCompletion) {
        
        let params: [String: Any] = ["api_key": "1f54bd990f1cdfb230adb312546d765d",
                                     "language": "pt-BR",
                                     "page": page]
        
        Alamofire.request("https://api.themoviedb.org/3/movie/upcoming", method: .get, parameters: params)
            .responseData { response in
                let result: Result<MoviesList> = JSONDecoder().decodeResponse(from: response)
                
                switch result {
                case .success(let result):
                    completion(result, nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
