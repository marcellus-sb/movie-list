//
//  MoviesList.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 21/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

struct MoviesList: Decodable {
    var results: [Movie]?
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
}
